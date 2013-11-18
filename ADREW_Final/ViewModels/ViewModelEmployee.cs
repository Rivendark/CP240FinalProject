﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections.ObjectModel;
using System.Data.Entity;
using ADREW_Final.Models;
using System.Diagnostics;
using System.Data;
using System.Data.SqlClient;

namespace ADREW_Final.ViewModels
{
    class ViewModelEmployee
    {
        private ObservableCollection<CEmployee> _EmpCol = new ObservableCollection<CEmployee>();
        private ObservableCollection<CDepartment> _DeptCol = new ObservableCollection<CDepartment>();
        private ObservableCollection<CPosition> _DeptPosCol = new ObservableCollection<CPosition>();

        private MainWindow _Handle;
        private finalDBEContext _EmpContext;

        public ObservableCollection<CEmployee> EmpCol
        {
            get { return _EmpCol; }
        }

        public ViewModelEmployee(MainWindow Handle)
        {
            _Handle = Handle;

            using (_EmpContext = new finalDBEContext(MainWindow.ConnectionString))
            {
                _Handle.LabelHost.Content = _EmpContext.Database.Connection.DataSource.ToString();
                _Handle.LabelDatabase.Content = _EmpContext.Database.Connection.Database.ToString();
            }
           
        }

        public bool BindToClass(){
            try
            {
                using (_EmpContext = new finalDBEContext(MainWindow.ConnectionString))
                {
                    foreach (var D in _EmpContext.Departments)
                    {
                        _DeptCol.Add(new CDepartment(D as Department));
                    }
                }                
            }
            catch
            {
                _Handle.InfoBox.Content = "An Error has Occured while loading Departments";
                return false;
            }

            try
            {
                using (_EmpContext = new finalDBEContext(MainWindow.ConnectionString))
                {
                    foreach (var D in _EmpContext.DepartmentPositions)
                    {
                        _DeptPosCol.Add(new CPosition(D as DepartmentPosition));
                    }
                }              
            }
            catch
            {
                _Handle.InfoBox.Content = "An Error has Occured while loading Department Positions";
                return false;
            }

            try
            {
                using (_EmpContext = new finalDBEContext(MainWindow.ConnectionString))
                {
                    foreach (var E in _EmpContext.Employees)
                    {
                        CEmployee Emp = new CEmployee(E as Employee);
                        foreach (CPosition P in _DeptPosCol)
                        {
                            if (P.PositionID == E.PositionID)
                            {
                                Emp.Position = P;
                                break;
                            }
                        }
                        foreach (CDepartment D in _DeptCol)
                        {
                            if (D.ID == Emp.Position.DepartmentID)
                            {
                                Emp.Dept = D;
                                break;
                            }
                        }
                        _EmpCol.Add(Emp);
                    }
                }                            
            }
            catch(SyntaxErrorException e)
            {
                _Handle.InfoBox.Content = "An Error has Occured while loading Employees. Message:" + e.Message;
                return false;
            }
            _Handle.InfoBox.Content = "Employee Loading: Successiful";
            return true;
        }
    }
}
