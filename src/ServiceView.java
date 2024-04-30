package src;

import javax.swing.table.DefaultTableModel;
import javax.swing.JButton;
import javax.swing.JTextField;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.ScrollPaneConstants;
import javax.swing.table.TableColumn;

import java.awt.Color;
import java.awt.Font;
import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.Statement;

import java.io.BufferedReader;
import java.io.FileReader;

public class ServiceView extends JFrame
{
  private JPanel contentPane     = new JPanel();
  private JTable table           = new JTable();
  private JTextField textField   = new JTextField(10);
  private JScrollPane scrollPane = new JScrollPane();
  private JPanel topPanel        = new JPanel(new FlowLayout(FlowLayout.LEFT));
  private JButton searchButton   = new JButton("Search");

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
    String inputField = textField.getText().trim();
    try
    {
      PreparedStatement pst;
      DefaultTableModel model = (DefaultTableModel) table.getModel();

      if (inputField.isEmpty())
      {
        pst = databaseConnection.prepareStatement("SELECT * FROM service_t JOIN client_t ON service_t.Client_ID = client_t.Client_ID ORDER BY Service_ID");
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

    // Setups the top panel
    contentPane.add(topPanel, BorderLayout.NORTH);
    topPanel.add(textField);

    // Setups the search button
    searchButton.setBackground(Color.lightGray);
    searchButton.setForeground(Color.black);
    searchButton.setFont(new Font("Tahoma", Font.PLAIN, 12));

    // Setups the action listener for the search button
    searchButton.addActionListener(new ActionListener()
    {
      public void actionPerformed(ActionEvent e)
      {
        String searchQuery = "SELECT * FROM service_t JOIN client_t ON service_t.Client_ID = client_t.Client_ID WHERE (client_t.First_Name LIKE ? OR client_t.Last_Name LIKE ?)";
        setServiceTableData(searchQuery);
      }
    });

    topPanel.add(searchButton);
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
