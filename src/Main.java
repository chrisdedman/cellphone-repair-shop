package src;

import java.awt.EventQueue;
import javax.swing.JFrame;

public class Main extends JFrame
{
  private ServiceView serviceView;

  public Main()
  {
    setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    setBounds(100, 100, 800, 361);
    setTitle("Cell Phone Repair Shop Database");

    serviceView = new ServiceView();
    setContentPane(serviceView.getContentPane());
  }

  public static void main(String[] args)
  {
    EventQueue.invokeLater(new Runnable()
    {
      public void run()
      {
        try
        {
          ServiceView.runSQLScript("schema/init_database.sql");
          ServiceView.runSQLScript("schema/create_tables.sql");
          ServiceView.runSQLScript("schema/data/client_data.sql");
          ServiceView.runSQLScript("schema/data/technician_data.sql");
          ServiceView.runSQLScript("schema/data/service_data.sql");
          ServiceView.runSQLScript("schema/data/device_data.sql");
          ServiceView.runSQLScript("schema/data/technician_device_data.sql");

          Main frame = new Main();
          frame.setVisible(true);
        }
        catch (Exception e)
        {
          e.printStackTrace();
        }
      }
    });
  }
}
