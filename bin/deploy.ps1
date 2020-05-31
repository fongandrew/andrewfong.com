$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Push-Location $scriptDir\..
[Environment]::CurrentDirectory = $PWD

If (Test-Path -Path dist) {
    aws s3 sync dist 's3://www.andrewfong.com' `
        --exclude '*.html' --exclude '*.css';
    aws s3 sync dist 's3://www.andrewfong.com' `
        --content-type 'text/css; charset=utf-8' --exclude '*' --include '*.css';
    aws s3 sync dist 's3://www.andrewfong.com' `
        --content-type 'text/html; charset=utf-8' `
        --exclude '*' --include '*.html';
} Else {
    Write-Output "Run 'npm run build' first";
    exit 1;
}

If (Test-Path -Path static) {
    aws s3 sync static 's3://www.andrewfong.com/static' `
        --exclude '*.html' --exclude '*.css';
    aws s3 sync static 's3://www.andrewfong.com/static' `
        --content-type 'text/css; charset=utf-8' --exclude '*' --include '*.css';
    aws s3 sync static 's3://www.andrewfong.com/static' `
        --content-type 'text/html; charset=utf-8' `
        --exclude '*' --include '*.html';
}

Pop-Location
[Environment]::CurrentDirectory = $PWD
