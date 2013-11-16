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
using DALS.SQLDialog;
using System.Data;
using ADREW_Final.Models;
using ADREW_Final.SQL;
using System.Collections.ObjectModel;
using ADREW_Final.ViewModels;

namespace ADREW_Final
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        
        ViewModelEmployee Employees;
        
        public MainWindow()
        {
            InitializeComponent();
            Employees = new ViewModelEmployee(this);
            EmpDataGrid.ItemsSource = Employees.EmpCol;
            Employees.BindToClass();

            ConnectedImage.Visibility = Visibility.Visible;
            DisconnectedImage.Visibility = Visibility.Collapsed;
            
        }

        #region MenuMethods
        private void MenuItemOpen_Click(object sender, RoutedEventArgs e)
        {
            if (SQLDAL.DCDConnect())
            {
                
            }
            else
            {
                InfoBox.Content = "Connection Failed for: " + SQLDAL.HostName + " : " + SQLDAL.DBName;
            }
        }

        private void MenuItemNewEmp_Click(object sender, RoutedEventArgs e)
        {
            using (finalDBEntities _EmpContext = new finalDBEntities())
            {
                Project P = _EmpContext.Projects.FirstOrDefault(Projects => Projects.ProjectID == 1);
                P.Name = "External: " + P.Name;
                _EmpContext.SaveChanges();
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
