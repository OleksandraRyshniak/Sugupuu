using System.IO;
using System.Xml;
using System.Xml.Xsl;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace sugulasedRakendusXML.Pages
{
    public class ReisModel : PageModel
    {
        private readonly IWebHostEnvironment _env;

        public string XmlHtml { get; private set; } = "";

        public ReisModel(IWebHostEnvironment env)
        {
            _env = env;
        }

        public void OnGet()
        {
            var xmlPath = Path.Combine(_env.WebRootPath, "Reis.xml");
            var xsltPath = Path.Combine(_env.WebRootPath, "ReisParing.xslt");

            var xslt = new XslCompiledTransform();
            xslt.Load(xsltPath);

            using var sw = new StringWriter();
            using var reader = XmlReader.Create(xmlPath);
            xslt.Transform(reader, null, sw);

            XmlHtml = sw.ToString();
        }
    }
}