<?php

function getById(string $id) {
    $ch = curl_init($id);
    curl_setopt_array($ch, [
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_RETURNTRANSFER => true
    ]);
    return curl_exec($ch);
}

function handleSaxonError($obj) {
    $errCount = $obj->getExceptionCount();
    for ($i = 0; $i < $errCount; $i++) {
        echo $obj->getErrorCode($i) . ' ' . $obj->getErrorMessage($i) . "<br/>\n";
    }
    $obj->exceptionClear();
}

$input  = 'tmp.xml';
$xslt   = 'xslt.xml';
file_put_contents($input, getById(filter_input(INPUT_GET, 'xml')));
file_put_contents($xslt, str_replace('saxon:cdata-section-elements="script"', '', getById(filter_input(INPUT_GET, 'xslt'))));

$saxonProc = new Saxon\SaxonProcessor();
$xsltProc = $saxonProc->newXslt30Processor();
echo $xsltProc->transformFileToString($input, $xslt);
handleSaxonError($xsltProc);
$xsltProc->clearParameters();
$xsltProc->clearProperties();

