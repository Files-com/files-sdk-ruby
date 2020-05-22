const downloadFileById = async (fileId, z) => {
  const response = await z.request({
    method: 'GET',
    url: 'https://app.files.com/api/rest/v1/files/',
    params: {
      id: fileId,
    },
  })

  const downloadUri = z.JSON.parse(response.content).download_uri

  return await z.request({
    method: 'GET',
    url: downloadUri,
    raw: true,
  })
}

const hydrators = {
  downloadFile: (z, bundle) => z.stashFile(downloadFileById(bundle.inputData.fileId, z))
}

module.exports = hydrators;