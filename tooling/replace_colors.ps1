$files = @()
$files += Get-ChildItem -Path lib/modules -Recurse -Filter *.dart | Where-Object { $_.FullName -match '\\view\\' }
$files += Get-ChildItem -Path lib/shared/widgets -Recurse -Filter *.dart
$files += Get-Item lib/shared/style/app_input_decoration.dart, lib/shared/style/app_text_style.dart
$files = $files | Sort-Object FullName -Unique

$map = [ordered]@{
'0x1AFF6B00'='AppColors.c1aff6b00'
'0x30000000'='AppColors.c30000000'
'0xFF00C853'='AppColors.c00c853'
'0xFF0F6B3A'='AppColors.c0f6b3a'
'0xFF1565C0'='AppColors.c1565c0'
'0xFF161616'='AppColors.c161616'
'0xFF1877F2'='AppColors.c1877f2'
'0xFF1F1F1F'='AppColors.c1f1f1f'
'0xFF20A464'='AppColors.c20a464'
'0xFF222222'='AppColors.c222222'
'0xFF242424'='AppColors.c242424'
'0xFF25D366'='AppColors.c25d366'
'0xFF272727'='AppColors.c272727'
'0xFF2D2D2D'='AppColors.c2d2d2d'
'0xFF2D3635'='AppColors.c2d3635'
'0xFF37423D'='AppColors.c37423d'
'0xFF43A047'='AppColors.c43a047'
'0xFF444444'='AppColors.c444444'
'0xFF454545'='AppColors.c454545'
'0xFF4CAF50'='AppColors.c4caf50'
'0xFF535353'='AppColors.c535353'
'0xFF5A67F2'='AppColors.c5a67f2'
'0xFF5C5C5C'='AppColors.c5c5c5c'
'0xFF6A6A6A'='AppColors.c6a6a6a'
'0xFF6B0903'='AppColors.c6b0903'
'0xFF6C4CE6'='AppColors.c6c4ce6'
'0xFF6C63FF'='AppColors.c6c63ff'
'0xFF6D6D6D'='AppColors.c6d6d6d'
'0xFF777777'='AppColors.c777777'
'0xFF7A7A7A'='AppColors.c7a7a7a'
'0xFF7C5CFC'='AppColors.c7c5cfc'
'0xFF808080'='AppColors.c808080'
'0xFF8A8A8A'='AppColors.c8a8a8a'
'0xFF8B8B8B'='AppColors.c8b8b8b'
'0xFF8C8C8C'='AppColors.c8c8c8c'
'0xFF9A9A9A'='AppColors.c9a9a9a'
'0xFF9B9BA1'='AppColors.c9b9ba1'
'0xFFB9ACF7'='AppColors.cb9acf7'
'0xFFC5C5C5'='AppColors.cc5c5c5'
'0xFFC9C9C9'='AppColors.cc9c9c9'
'0xFFE1306C'='AppColors.ce1306c'
'0xFFE1E1E1'='AppColors.ce1e1e1'
'0xFFE3E3E3'='AppColors.ce3e3e3'
'0xFFE5E5EA'='AppColors.ce5e5ea'
'0xFFE8E8E8'='AppColors.ce8e8e8'
'0xFFE8E8EE'='AppColors.ce8e8ee'
'0xFFEAEAEA'='AppColors.ceaeaea'
'0xFFECECEC'='AppColors.cececec'
'0xFFEDE8FF'='AppColors.cede8ff'
'0xFFEDEDED'='AppColors.cededed'
'0xFFEEEEEE'='AppColors.ceeeeee'
'0xFFEEF1FF'='AppColors.ceef1ff'
'0xFFEFF4FF'='AppColors.ceff4ff'
'0xFFF0F0F0'='AppColors.cf0f0f0'
'0xFFF0F4F2'='AppColors.cf0f4f2'
'0xFFF1F1F1'='AppColors.cf1f1f1'
'0xFFF2F0FA'='AppColors.cf2f0fa'
'0xFFF3F2FA'='AppColors.cf3f2fa'
'0xFFF3F3F3'='AppColors.cf3f3f3'
'0xFFF3F3F5'='AppColors.cf3f3f5'
'0xFFF4EFF1'='AppColors.cf4eff1'
'0xFFF4F4F7'='AppColors.cf4f4f7'
'0xFFF5EFF5'='AppColors.cf5eff5'
'0xFFF5F1F6'='AppColors.cf5f1f6'
'0xFFF5F5F5'='AppColors.cf5f5f5'
'0xFFF5F5F7'='AppColors.cf5f5f7'
'0xFFF5F7FA'='AppColors.cf5f7fa'
'0xFFF6F4F5'='AppColors.cf6f4f5'
'0xFFF6F4F7'='AppColors.cf6f4f7'
'0xFFF6F8FC'='AppColors.cf6f8fc'
'0xFFF7EFF4'='AppColors.cf7eff4'
'0xFFF7F7F3'='AppColors.cf7f7f3'
'0xFFF7F7F7'='AppColors.cf7f7f7'
'0xFFF8F8F8'='AppColors.cf8f8f8'
'0xFFF8F8FA'='AppColors.cf8f8fa'
'0xFFF8FAFC'='AppColors.cf8fafc'
'0xFFF9B233'='AppColors.cf9b233'
'0xFFFAFAFA'='AppColors.cfafafa'
'0xFFFCFCFC'='AppColors.cfcfcfc'
'0xFFFF4E86'='AppColors.cff4e86'
'0xFFFF6B00'='AppColors.cff6b00'
'0xFFFFB547'='AppColors.cffb547'
'0xFFFFB5C8'='AppColors.cffb5c8'
'0xFFFFF3EA'='AppColors.cfff3ea'
'0xFFFFFFFF'='AppColors.white'
}

foreach ($f in $files) {
  $content = Get-Content -Raw -Path $f.FullName
  foreach ($hex in $map.Keys) {
    $pattern = '(?:const\s+)?Color\(' + [regex]::Escape($hex) + '\)'
    $content = [regex]::Replace($content, $pattern, $map[$hex], 'IgnoreCase')
  }

  if ($content -notmatch 'app_colors.dart') {
    $lines = $content -split "`r?`n"
    $lastImport = -1
    for ($i = 0; $i -lt $lines.Count; $i++) {
      if ($lines[$i] -match '^import\s') {
        $lastImport = $i
      }
    }

    if ($lastImport -ge 0) {
      $before = @()
      if ($lastImport -gt 0) {
        $before = $lines[0..$lastImport]
      } else {
        $before = @($lines[0])
      }
      $after = @()
      if ($lastImport + 1 -lt $lines.Count) {
        $after = $lines[($lastImport + 1)..($lines.Count - 1)]
      }
      $lines = @($before + "import 'package:imoss/shared/style/app_colors.dart';" + $after)
    } else {
      $lines = @("import 'package:imoss/shared/style/app_colors.dart';" + $lines)
    }

    $content = $lines -join "`r`n"
  }

  Set-Content -Path $f.FullName -Value $content -Encoding UTF8
}

"Updated files: $($files.Count)"
