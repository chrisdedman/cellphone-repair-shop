package src;

import javax.swing.table.DefaultTableModel;
import javax.swing.JButton;
import javax.swing.JTextField;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.ScrollPaneConstants;
import java.awt.Color;
import java.awt.EventQueue;
import java.awt.Font;
import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

public class ServiceView extends JFrame {

  private JPanel contentPane      = new JPanel();
  private JTable table            = new JTable();
  private JTextField textField    = new JTextField(10);
  private JScrollPane scrollPane  = new JScrollPane();
  private JPanel topPanel         = new JPanel(new FlowLayout(FlowLayout.LEFT));
  private JButton btnNewButton    = new JButton("Search");

  public static void main(String[] args) {
    EventQueue.invokeLater(new Runnable() {
      public void run() {
        try {
          ServiceView frame = new ServiceView();
          frame.setVisible(true);
        } catch (Exception e) {
          e.printStackTrace();
        }
      }
    });
  }

  public void SetTable() {
    table.setFont(new Font("Tahoma", Font.PLAIN, 12));
    table.setModel(new DefaultTableModel(
        new Object[][] {
            /*
             * Sample data for testing
             * remove this data and fetch data from the database
             * when done with implementing the database connections
             */
            { 1, 1, "Screen", "Repair", 100.0 },
            { 2, 1, "Battery", "Change", 88.98 }
        },
        new String[] {
            "Service ID",
            "Client ID",
            "Part",
            "Service Type",
            "Cost"
        }));
    scrollPane.setViewportView(table);
  }

  public void SetServiceTableData(String searchQuery) {
    String id = textField.getText().trim();
    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection databaseConnection = DriverManager.getConnection(
          "jdbc:mysql://127.0.0.1:3306/cellphone",
          "root",
          "1234");
      PreparedStatement pst;
      DefaultTableModel model = (DefaultTableModel) table.getModel();

      if (id.isEmpty()) {
        pst = databaseConnection.prepareStatement("SELECT * FROM service_t");
      } else {
        pst = databaseConnection.prepareStatement(searchQuery);
        pst.setString(1, id);
      }

      ResultSet rs = pst.executeQuery();
      model.setRowCount(0);

      while (rs.next()) {
        model.addRow(new Object[] {
            rs.getInt("Service_ID"),
            rs.getInt("Client_ID"),
            rs.getString("Part"),
            rs.getString("Service_Type"),
            rs.getDouble("Cost")
        });
      }
      table.setModel(model);
    } catch (Exception e1) {
      e1.printStackTrace();
    }
  }

  public ServiceView() {
    // Setups the frame
    setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    setBounds(100, 100, 800, 361);
    setTitle("Cell Phone Repair Shop Database");

    // Setups the content pane
    contentPane.setBackground(new Color(240, 240, 240));
    setContentPane(contentPane);
    contentPane.setLayout(new BorderLayout());

    // Setups the scroll pane
    scrollPane.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);
    contentPane.add(scrollPane, BorderLayout.CENTER);

    // Setups the table
    SetTable();

    // Setups the top panel
    contentPane.add(topPanel, BorderLayout.NORTH);
    topPanel.add(textField);

    // Setups the search button
    btnNewButton.setBackground(Color.lightGray);
    btnNewButton.setForeground(Color.black);
    btnNewButton.setFont(new Font("Tahoma", Font.PLAIN, 12));

    // Setups the action listener for the search button
    btnNewButton.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        String searchQuery = "SELECT * FROM service_t WHERE Service_ID = ?";
        SetServiceTableData(searchQuery);
      }
    });
    topPanel.add(btnNewButton);
  }
}
