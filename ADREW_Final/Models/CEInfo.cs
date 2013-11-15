using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ADREW_Final.Models
{
    class CEInfo : ModelBase
    {
        #region EmployeeInfo Entity Model Variable
        private EmployeeInfo _EmpInfo;

        public EmployeeInfo EmpWage
        {
            get { return _EmpInfo; }
            set { _EmpInfo = value; }
        }
        #endregion

        private DateTime _DOB;
        private string _Email = "";
        private string _Address;
        private string _City;
        private string _Zip;
        private string _State;
        private string _Phone;

        public string Age
        {
            get
            {
                return "4";
            }
        }
        
        public string Email
        {
            get { return _Email; }
            set { _Email = value; }
        }

        public string Address
        {
            get { return _Address; }
            set { _Address = value; }
        }

        public string City
        {
            get { return _City; }
            set { _City = value; }
        }

        public string Zip
        {
            get { return _Zip; }
            set { _Zip = value; }
        }

        public string State
        {
            get { return _State; }
            set { _State = value; }
        }

        public string Phone
        {
            get { return _Phone; }
            set { _Phone = value; }
        }

        public CEInfo() { }

        public CEInfo(EmployeeInfo EI)
        {
            _EmpInfo = EI;
            _DOB = Convert.ToDateTime(EI.DOB);
            Email = EI.EEmail;
            Address = EI.EAddress;
            City = EI.ECity;
            Zip = EI.Zip;
            State = EI.EState;
            Phone = EI.EPhone;
        }
    }
}
