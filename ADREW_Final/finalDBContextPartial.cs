using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;

namespace ADREW_Final
{
    public partial class finalDBEContext : DbContext
    {
        public finalDBEContext(string Conn)
            : base(Conn)
        {

        }
    }
}
