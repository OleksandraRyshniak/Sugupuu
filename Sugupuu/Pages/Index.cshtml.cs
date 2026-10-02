using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Xml.Xsl;

namespace Sugupuu.Pages
{
    public class IndexModel : PageModel
    {
        public string TransformedXml { get; private set; } = "";
        private readonly IWebHostEnvironment _hostingEnvironment;

        public IndexModel(IWebHostEnvironment hostingEnvironment)
        {
            _hostingEnvironment = hostingEnvironment;
        }

        public void OnGet()
        {
            try
            {
                var xmlPath = Path.Combine(_hostingEnvironment.ContentRootPath, "wwwroot", "ElizavetaSugupuu.xml");
                var xsltPath = Path.Combine(_hostingEnvironment.ContentRootPath, "wwwroot", "sugupuuParing.xslt");

                if (!System.IO.File.Exists(xmlPath) || !System.IO.File.Exists(xsltPath))
                {
                    TransformedXml = "<p class='text-danger'>Ошибка: XML или XSLT файл не найден.</p>";
                    return;
                }

                var xslt = new XslCompiledTransform();
                xslt.Load(xsltPath);

                using (var sw = new StringWriter())
                {
                    xslt.Transform(xmlPath, null, sw);
                    TransformedXml = sw.ToString();
                }
            }
            catch (Exception ex)
            {
                TransformedXml = $"<p class='text-danger'>Ошибка преобразования XML: {ex.Message}</p>";
            }
        }
    }
}