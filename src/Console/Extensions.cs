namespace SmabInv;
internal static partial class Extensions
{
	extension(PropertyData? propertyData)
	{
		public string ToPropertyString()
		{
			if (propertyData?.Value is null) { return ""; };

			return propertyData.IsArray
				? propertyData.Type switch
				{
					CimType.UInt16 => string.Join(",", (UInt16[])propertyData.Value),
					CimType.String => string.Join(Environment.NewLine, (string[])propertyData.Value),
					_ => propertyData.Value.ToString() ?? "",
				}
				: propertyData?.Value?.ToString() ?? "";
		}
	}
}
