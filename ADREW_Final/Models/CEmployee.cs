using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;
using System.Data;
using System.Windows;
using System.Diagnostics;

namespace ADREW_Final.Models
{
    class CEmployee : ModelBase
    {
        #region Employee Entity Model
        private Employee _EmployeeModel;

        public Employee EmployeeModel
        {
            get { return _EmployeeModel; }
        }
        #endregion

        #region Employee Variables
        private int         _ID;
        private string      _FName          = "";
        private string      _MI             = "";
        private string      _LName          = "";
        private string      _UName          = "";
        private DateTime    _DOH            = DateTime.Now.Date;
        private CDepartment _Dept           = null;
        private CPosition   _DeptPos        = null;
        private CWage       _EmpWages       = null;
        private CEInfo      _EmpInfo        = null;

        public int ID { 
            get { return _ID; }
            private set { _ID = value; }
        }

        public string FName{
            get { return _FName; }
            set
            {
                if (_FName != value)
                {   
                    _FName = value;                    
                }
            }
        }

        public string MI {
            get { return _MI; }
            set
            {
                if (_MI != value)
                {
                    _MI = value;
                }
            }
        }

        public string LName {
            get { return _LName; }
            set
            {
                if (_LName != value)
                {
                    _LName = value;
                }
            }
        }

        public string UName {
            get { return _UName; }
            set
            {
                if (_UName != value)
                {
                    _UName = value;
                }
            }
        }

        public string DOH {
            get { return _DOH.ToShortDateString(); }
            set
            {
                if (_DOH != Convert.ToDateTime(value))
                {
                    _DOH = Convert.ToDateTime(value);
                }
            }
        }

        public CDepartment Dept {
            get { return _Dept; }
            set
            {
                if (_Dept != value)
                {
                    _Dept = value;
                }
            }
        }

        public CPosition Position {
            get { return _DeptPos; }
            set
            {
                if (_DeptPos != value)
                {
                    _DeptPos = value;
                }
            }
        }

        public CWage EmpWages {
            get { return _EmpWages; }
            set
            {
                if (_EmpWages != value)
                {
                    _EmpWages = value;
                }
            }
        }

        public CEInfo EmpInfo
        {
            get { return _EmpInfo; }
            set
            {
                if(_EmpInfo != value){
                    _EmpInfo = value;
                }
            }
        }
        #endregion
       
        #region Constructors
        /// <summary>
        /// CEmployee Constructor Methods
        /// Initializes New CEmployee
        /// </summary>
        /// <param name="id"></param>
        /// 
        public CEmployee(int id) {
            _ID = id;
            _IsNew = true;
        }

        /// <summary>
        /// Constructor for CEmployee, takes in Employee Model from Entity Framework
        /// </summary>
        /// <param name="E"></param>
        public CEmployee(Employee E) {
            _EmployeeModel = E;

            _ID = E.EmployeeID;
            _UName = E.UserName;
            _FName = E.FName;
            _LName = E.LName;
            _MI = E.MI;
            _DOH = E.DateOfHire;
            EmployeeInfo EI = E.EmployeeInfoes.FirstOrDefault() as EmployeeInfo;
            if(EI != null)
                _EmpInfo = new CEInfo(EI);
           

        }
        #endregion

        #region Class Functions
        ///<summary>
        ///public void UpdateID(int id){}
        ///</summary>
        ///used when adding a new employee and inserting them into a project/dept position
        public void UpdateID(int NewID)
        {
            if(_ID == -1)
                ID = NewID;          
        }
        #endregion

    }
}
