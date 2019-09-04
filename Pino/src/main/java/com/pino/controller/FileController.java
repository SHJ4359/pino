package com.pino.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping(value = "/file/*")
public class FileController {
	
	@Resource(name = "uploadPath")
	private String uploadFolder;
	
	@RequestMapping(value = "/fileUpload", method = RequestMethod.POST, produces = "text/plain; charset=utf-8")
	public String uploadFile(MultipartFile uploadFile) throws Exception {
		
//		System.out.println("Upload file name: " + uploadFile.getOriginalFilename());
//		System.out.println("Upload file size: " + uploadFile.getSize());
		
		String uploadFileName = uploadFile.getOriginalFilename();
		
		uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
		
		String saveName = saveFile(uploadFileName);
		
//		System.out.println("savaeName: " + saveName);
//		
//		System.out.println("uploadFolder: "  + uploadFolder);
		
		File saveFile = new File(uploadFolder, saveName);
		
		try {
			uploadFile.transferTo(saveFile);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		
		return saveName;
		
	}
	
	@RequestMapping(value = "/display")
	public ResponseEntity<byte[]> display(@RequestParam("fileName") String fileName) throws Exception {
		String realPath = "";
		realPath = uploadFolder + File.separator + fileName;
		
//		System.out.println("realPath: " + realPath);
		InputStream is = null;
		ResponseEntity<byte[]> entity = null;
		
		try {
			HttpHeaders headers = new HttpHeaders();
			
			int underScoreIndex = 0;
			String downloadName = "";
			underScoreIndex = fileName.indexOf("_", 1);
			downloadName = fileName.substring(underScoreIndex + 1);
			is = new FileInputStream(realPath);
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			headers.add("Content-disposition", "attachment); filename=\"" + downloadName + "\"");
			
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(is), headers, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}	
	
	private String saveFile(String file) {
		UUID uuid = UUID.randomUUID();
		String saveName = uuid + "_" + file;
		
		return saveName;
	}
}
