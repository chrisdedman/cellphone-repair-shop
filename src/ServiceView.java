package src;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JLabel;
import javax.swing.JTable;
import javax.swing.ImageIcon;
import javax.swing.JTextField;
import javax.swing.JScrollPane;
import javax.swing.table.TableColumn;
import javax.swing.event.DocumentEvent;
import javax.swing.ScrollPaneConstants;
import javax.swing.event.DocumentListener;
import javax.swing.table.DefaultTableModel;

import java.awt.Font;
import java.awt.Color;
import java.awt.Image;
import java.awt.FlowLayout;
import java.awt.BorderLayout;

import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import java.io.FileReader;
import java.io.BufferedReader;

public class ServiceView extends JFrame
{
  private JPanel contentPane     = new JPanel();
  private JTable table           = new JTable();
  private JTextField searchField = new JTextField(10);
  private JScrollPane scrollPane = new JScrollPane();
  private JPanel topPanel        = new JPanel(new FlowLayout(FlowLayout.LEFT));
  private JLabel searchIconLabel;

  private static Connection databaseConnection;

  public static void runSQLScript(String fileName)
  {
    try
    {
      Class.forName("com.mysql.cj.jdbc.Driver");
      databaseConnection = DriverManager.getConnection(
        "jdbc:mysql://127.0.0.1:3306/cellphone",
        "root",
        "1234"
      );

      Statement statement   = databaseConnection.createStatement();
      BufferedReader reader = new BufferedReader(new FileReader(fileName));
      StringBuilder query   = new StringBuilder();
      String line;

      while ((line = reader.readLine()) != null)
      {
        if (!line.trim().startsWith("--") && !line.trim().isEmpty())
        {
          query.append(line);
          if (line.trim().endsWith(";"))
          {
            statement.executeUpdate(query.toString());
            query = new StringBuilder();
          }
        }
      }

      reader.close();
      statement.close();
    }

    catch (Exception e)
    {
      e.printStackTrace();
    }
  }

  public void setTable()
  {
    table.setFont(new Font("Tahoma", Font.PLAIN, 12));
    DefaultTableModel model = new DefaultTableModel(
      new String[] {
          "Service ID",
          "Client ID",
          "First Name",
          "Last Name",
          "Part",
          "Service Type",
          "Cost"
      },
      0
    );

    table.setModel(model);
    scrollPane.setViewportView(table);
  }

  public void setServiceTableData(String searchQuery)
  {
    String inputField = searchField.getText().trim();
    try
    {
      PreparedStatement pst;
      DefaultTableModel model = (DefaultTableModel) table.getModel();

      if (inputField.isEmpty())
      {
        pst = databaseConnection.prepareStatement(
          "SELECT * FROM service_t " +
              "JOIN client_t " +
              "ON service_t.Client_ID = client_t.Client_ID " +
              "ORDER BY Service_ID"
        );
      }
      else
      {
        pst = databaseConnection.prepareStatement(searchQuery);
        pst.setString(1, inputField + "%");
        pst.setString(2, inputField + "%");
      }

      ResultSet rs = pst.executeQuery();
      model.setRowCount(0);

      while (rs.next())
      {
        model.addRow(new Object[]
        {
          rs.getInt("Service_ID"),
          rs.getInt("Client_ID"),
          rs.getString("First_name"),
          rs.getString("Last_name"),
          rs.getString("Part"),
          rs.getString("Service_Type"),
          "$" + rs.getDouble("Cost")
        });
      }
      table.setModel(model);
    }
    catch (Exception e1)
    {
      e1.printStackTrace();
    }
  }

  public ServiceView()
  {
    // Setups the content pane
    contentPane.setBackground(new Color(240, 240, 240));
    setContentPane(contentPane);
    
    contentPane.setLayout(new BorderLayout());

    // Setups the scroll pane
    scrollPane.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);
    contentPane.add(scrollPane, BorderLayout.CENTER);

    // Setups the table
    setTable();
    setServiceTableData("");
    setColumnsWidth(table, 800, 50, 50, 70, 80, 100, 80, 60);

    // Add search icon
    ImageIcon searchIcon = new ImageIcon("assets/search-icon.png");
    Image icon           = searchIcon.getImage();
    Image newIcon        = icon.getScaledInstance(20, 20,  java.awt.Image.SCALE_SMOOTH);
    searchIcon           = new ImageIcon(newIcon);
    searchIconLabel      = new JLabel(searchIcon);

    // Setups the top panel
    contentPane.add(topPanel, BorderLayout.NORTH);
    topPanel.add(searchIconLabel);
    topPanel.add(new JLabel("Search by Client's Name:"));
    topPanel.add(searchField);

    // Setups the search field
    searchField.getDocument().addDocumentListener(new DocumentListener()
    {
      @Override
      public void insertUpdate(DocumentEvent e)
      {
        updateTable();
      }

      @Override
      public void removeUpdate(DocumentEvent e)
      {
        updateTable();
      }

      @Override
      public void changedUpdate(DocumentEvent e)
      {
        updateTable();
      }
    });
  }

  private void updateTable()
  {
    String searchQuery = ("SELECT * FROM service_t " +
            "JOIN client_t " +
            "ON service_t.Client_ID = client_t.Client_ID " +
            "WHERE (client_t.First_Name LIKE ? " +
            "OR client_t.Last_Name LIKE ?)"
      );
    setServiceTableData(searchQuery);
  }

  public static void setColumnsWidth(JTable table, int tablePreferredWidth, double... percentages)
  {
    double total = 0;
    for (int i = 0; i < table.getColumnModel().getColumnCount(); i++)
    {
      total += percentages[i];
    }

    for (int i = 0; i < table.getColumnModel().getColumnCount(); i++)
    {
      TableColumn column = table.getColumnModel().getColumn(i);
      column.setPreferredWidth((int) (tablePreferredWidth * (percentages[i] / total)));
    }
  }

  public JPanel getContentPane()
  {
    return contentPane;
  }
}
