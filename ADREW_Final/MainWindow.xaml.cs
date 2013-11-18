using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Collections.ObjectModel;
using System.Data;
using System.Diagnostics;
using System.Data.SqlClient;
using System.Data.Entity.Core.EntityClient;
using System.Data.Common;

using DALS.SQLDialog;
using ADREW_Final.Models;
using ADREW_Final.SQL;
using ADREW_Final.ViewModels;

namespace ADREW_Final
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public static Dictionary<string, string> ConnDictionary = new Dictionary<string, string>();
        public static string MetaData = "res://*";
        private string TempPassword = "EndersGame1";
        public static string HostName = "Azure";
        public static string ConnectionString;

        ViewModelEmployee Employees;
        
        public MainWindow()
        {
            MainWindow.ConnDictionary.Add("Azure", "metadata=res://*;provider=System.Data.SqlClient;provider connection string=';data source=tcp:khg7zjnows.database.windows.net,1433;initial catalog=finalDB;persist security info=True;user id=nhti@khg7zjnows;password={0};connect timeout=30;encrypt=True;MultipleActiveResultSets=True';");
            
            InitializeComponent();
           
            MenuItem Conn = menuOpenConnection as MenuItem;
            foreach (string key in ConnDictionary.Keys)
            {
                MenuItem newMenuItem = new MenuItem();
                newMenuItem.Header = "DB:"+key;
                newMenuItem.Name = key;
                Conn.Items.Add(newMenuItem);
                newMenuItem.Click += new RoutedEventHandler(MenuItemOpen_Click);
                
            }

            ConnectionString = "";
        }

        public void LoadProgram()
        {
            Employees = new ViewModelEmployee(this);
            EmpDataGrid.ItemsSource = Employees.EmpCol;
            Employees.BindToClass();
        }

        public static bool GetEntityConnection(string Username, string Password, string Host, string Database, string Name, bool IntegratedSecurity)
        {
            string connectionString;
            if (IntegratedSecurity)
            {
                connectionString = new System.Data.EntityClient.EntityConnectionStringBuilder
                {
                    Metadata = "res://*",
                    Provider = "System.Data.SqlClient",
                    ProviderConnectionString = new System.Data.SqlClient.SqlConnectionStringBuilder
                    {
                        InitialCatalog = Database,
                        DataSource = Host,
                        IntegratedSecurity = true,
                        MultipleActiveResultSets = true
                    }.ConnectionString
                }.ConnectionString;
            }

            else
            {
                connectionString = new System.Data.EntityClient.EntityConnectionStringBuilder
                {
                    Metadata = "res://*",
                    Provider = "System.Data.SqlClient",
                    ProviderConnectionString = new System.Data.SqlClient.SqlConnectionStringBuilder
                    {
                        InitialCatalog = Database,
                        DataSource = Host,
                        IntegratedSecurity = false,
                        UserID = Username,
                        Password = Password,
                        MultipleActiveResultSets = true
                    }.ConnectionString
                }.ConnectionString;
            }

            try
            {
                using (var Context = new finalDBEContext(connectionString))
                {
                    Context.Database.Connection.Open();
                    Context.Database.Connection.Close();
                }
                
            }
            catch(Exception e)
            {
                Debug.WriteLine("Connection Failed. Message: " + e.Message);
                return false;
            }
            string BaseConnStr = connectionString;
            ConnDictionary.Add(Name, BaseConnStr.Replace(Password, "{0}"));

            ConnectionString = connectionString;
            return true;
        }

        public static string SetConnectionString(string password, string connStr)
        {
            return String.Format(connStr, password);
        }

        #region MenuMethods
        private void MenuItemOpen_Click(object sender, RoutedEventArgs e)
        {
            if (ConnectionString != "")
                ConnectionString = "";
            
            var MI = sender as MenuItem;
            string ConnName = MI.Name as string;

            Debug.WriteLine("Name = :" + ConnName);

            if (ConnDictionary.ContainsKey(ConnName))
            {
                ConnectionString = SetConnectionString(TempPassword, ConnDictionary[ConnName]);
            }
            try {
                LoadProgram();
                ConnectedImage.Visibility = Visibility.Visible;
                DisconnectedImage.Visibility = Visibility.Collapsed;
            }
            catch (Exception ex)
            {
                Debug.WriteLine("Exception Occured, Message: " + ex.Message);
            }      
        }

        private void MenuItemNewEmp_Click(object sender, RoutedEventArgs e)
        {
            using (var Context = new finalDBEContext())
            { 
                
            }
        }

        private void MenuItemNewProj_Click(object sender, RoutedEventArgs e)
        {
            //CProject CP = new CProject();
            //CP.IsNewProj = true;
            //ProjMgmt ProjMgmtWindow = new ProjMgmt(this, CP);
            //ProjMgmtWindow.Show();
        }

        private void MenuItemClose_Click(object sender, RoutedEventArgs e)
        {
            //SQLDAL.Disconnect();
        }

        private void MenuItemExit_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();
        }
        #endregion

        private void EmpDataGrid_RowDetailsVisibilityChanged(object sender, DataGridRowDetailsEventArgs e)
        {

        }

        private void EmpDataGrid_Loaded(object sender, RoutedEventArgs e)
        {

        }

        private void RowHeaderTB_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
