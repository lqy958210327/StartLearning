#if  UNITY_EDITOR
using System;
using System.Collections.Generic;
using System.IO;
// using OfficeOpenXml;

namespace SLMEditor
{
    public class ExcelHelper
    {
        public static string EXCELPAHT = "E:/Work/designDoc/SLMDoc";
        private static int STARTROW = 5;
        private static int IDCOLUMN = 1;
        private static int NAMEROW = 2;
        
        // private static Dictionary<string, ExcelWorksheet>  _dic = new Dictionary<string, ExcelWorksheet>();
        // public static ExcelPackage GetExcelPackage(string filePath)
        // {
        //     if (!File.Exists(filePath))
        //     {
        //         return null;
        //     }
        //
        //     FileStream file = null;
        //     try
        //     {
        //         file = new FileStream(filePath, FileMode.Open, FileAccess.Read,
        //             FileShare.Read);
        //     
        //         return new ExcelPackage(file);
        //     }
        //     finally
        //     {
        //         if (file != null)
        //         {
        //             file.Close();
        //         }
        //     } 
        // }
        //
        // public static ExcelWorksheet GetSLMExcelWorksheet(string fileName, int index)
        // {
        //     if (_dic.TryGetValue(fileName, out var sheet))
        //     {
        //         return sheet;
        //     }
        //     
        //     var excel = GetExcelPackage($"{EXCELPAHT}/{fileName}");
        //     if (excel == null)
        //         return null;
        //
        //     if (index > excel.Workbook.Worksheets.Count)
        //         return null;
        //
        //     return excel.Workbook.Worksheets[index];
        // }
        //
        // /// <summary>
        // /// 获取策划配置表
        // /// </summary>
        // public static ExcelWorksheet GetSLMExcel(string fileName)
        // {
        //     return GetSLMExcelWorksheet(fileName, 1);
        // }
        //
        // /// <summary>
        // /// 获取策划配置表
        // /// <param name="id">配置表行ID</param>
        // /// <param name="columnName">配置表列名</param>
        // /// </summary>
        // public static T GetSLMExcelValue<T>(ExcelWorksheet sheet, int id, string columnName)
        // {
        //     var column = GetNameAtColumn(sheet, columnName);
        //     if (column == -1)
        //         return default;
        //
        //     for (int i = STARTROW; i <= sheet.Dimension.End.Row; i++)
        //     {
        //         var rowID = sheet.GetValue<int>(i, IDCOLUMN);
        //         if (rowID == id)
        //         {
        //             return sheet.GetValue<T>(i, column);
        //         }
        //     }
        //
        //     return default;
        // }
        //
        //
        //
        // public static int GetNameAtColumn(ExcelWorksheet sheet, string name)
        // {
        //     for (int j = 1; j <= sheet.Dimension.End.Column; j++)
        //     {
        //         var value = sheet.GetValue<string>(NAMEROW, j);
        //         if (value == name)
        //             return j;
        //     }
        //
        //     return -1;
        // }
        //
        // public static void RefreshAllSLMExcel()
        // {
        //     _dic.Clear();
        //     var path = $"{EXCELPAHT}";
        //     DirectoryInfo direction = new DirectoryInfo(path);
        //     var files = direction.GetFiles("*.xlsx");
        //     foreach (var excel in files)
        //     {
        //         try
        //         {
        //             var package = GetExcelPackage(excel.FullName);
        //             _dic.Add(excel.Name, package.Workbook.Worksheets[1]);
        //         }
        //         catch (Exception e)
        //         {
        //             //Debug.LogError($"文件:{excel.Name} 错误:{e}");
        //         }
        //     }
        // }
    }
}
#endif