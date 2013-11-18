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

        #region CEInfo Variables
        private DateTime _DOB;       
        private string _Email = "";
        private string _Address;
        private string _City;
        private string _Zip;
        private string _State;
        private string _Phone;

        public DateTime DOB
        {
            get { return _DOB; }
            set{
                if (_DOB != value)
                {
                    IsChanged = true;
                    _DOB = value;
                }
            }
        }

        public string Age
        {
            get
            {
                DateTime now = DateTime.Today;
                int age = now.Year - _DOB.Year;
                if (now.Month < _DOB.Month || (now.Month == _DOB.Month && now.Day < _DOB.Day)) age--;
                return age.ToString();
            }
        }
        
        public string Email
        {
            get { return _Email; }
            set
            {
                if (_Email != value)
                {
                    IsChanged = true;
                    _Email = value;
                }
            }
        }

        public string Address
        {
            get { return _Address; }
            set
            {
                if (_Address != value)
                {
                    IsChanged = true;
                    _Address = value;
                }
            }
        }

        public string City
        {
            get { return _City; }
            set
            {
                if (_City != value)
                {
                    IsChanged = true;
                    _City = value;
                }
            }
        }

        public string Zip
        {
            get { return _Zip; }
            set
            {
                if (_Zip != value)
                {
                    IsChanged = true;
                    _Zip = value;
                }
            }
        }

        public string State
        {
            get { return _State; }
            set
            {
                if (_State != value)
                {
                    IsChanged = true;
                    _State = value;
                }
            }
        }

        public string Phone
        {
            get { return _Phone; }
            set
            {
                if (_Phone != value)
                {
                    IsChanged = true;
                    _Phone = value;
                }
            }
        }
        #endregion

        public CEInfo() { }

        public CEInfo(EmployeeInfo EI)
        {
            _EmpInfo = EI;
            SetFromEntity();
        }

        private void SetFromEntity()
        {
            if (_EmpInfo != null)
            {
                _DOB = Convert.ToDateTime(_EmpInfo.DOB);
                Email = _EmpInfo.EEmail;
                Address = _EmpInfo.EAddress;
                City = _EmpInfo.ECity;
                Zip = _EmpInfo.Zip;
                State = _EmpInfo.EState;
                Phone = _EmpInfo.EPhone;
            }
        }

        public override void AcceptChanges()
        {
            _EmpInfo.DOB = _DOB;
            _EmpInfo.EEmail = _Email;
            _EmpInfo.EAddress = _Address;
            _EmpInfo.ECity = _City;
            _EmpInfo.EState = _State;
            _EmpInfo.Zip = _Zip;
            _EmpInfo.EPhone = _Phone;
        }

        public override void RejectChanges()
        {
            SetFromEntity();
        }

        public void RemoveChange(string propertyName)
        {
            switch (propertyName)
            {
                case "DOB":
                    if (DOB != _EmpInfo.DOB)
                    {
                        DOB = Convert.ToDateTime(_EmpInfo.DOB);
                    }
                    break;

                case "Email":
                    if (Email != _EmpInfo.EEmail)
                    {
                        Email = _EmpInfo.EEmail;
                    }
                    break;

                case "Address":
                    if (Address != _EmpInfo.EAddress)
                    {
                        Address = _EmpInfo.EAddress;
                    }
                    break;

                case "City":
                    if (City != _EmpInfo.ECity)
                    {
                        City = _EmpInfo.ECity;
                    }
                    break;

                case "State":
                    if (State != _EmpInfo.EState)
                    {
                        State = _EmpInfo.EState;
                    }
                    break;

                case "Zip":
                    if (Zip != _EmpInfo.Zip)
                    {
                        Zip = _EmpInfo.Zip;
                    }
                    break;

                case "Phone":
                    if (Phone != _EmpInfo.EPhone)
                    {
                        Phone = _EmpInfo.EPhone;
                    }
                    break;

                default:
                    return;
            }
            return;
        }
    }
}
