using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections.ObjectModel;
using ADREW_Final.Models;
using System.Diagnostics;
using System.Data;

namespace ADREW_Final.ViewModels
{
    class ViewModelEmployee
    {
        private ObservableCollection<CEmployee> _EmpCol = new ObservableCollection<CEmployee>();
        private ObservableCollection<CDepartment> _DeptCol = new ObservableCollection<CDepartment>();
        private ObservableCollection<CPosition> _DeptPosCol = new ObservableCollection<CPosition>();

        private MainWindow _Handle;
        private finalDBEntities _EmpContext;

        public ObservableCollection<CEmployee> EmpCol
        {
            get { return _EmpCol; }
        }

        public ViewModelEmployee(MainWindow Handle)
        {
            _Handle = Handle;
        }

        public bool BindToClass(){
            try
            {
                using (_EmpContext = new finalDBEntities()){
                    foreach(var D in _EmpContext.Departments){
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
                using (_EmpContext = new finalDBEntities())
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
                using (_EmpContext = new finalDBEntities())
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
            catch
            {
                _Handle.InfoBox.Content = "An Error has Occured while loading Employees";
                return false;
            }
            _Handle.InfoBox.Content = "Employee Loading: Successiful";
            return true;
        }
    }
}
