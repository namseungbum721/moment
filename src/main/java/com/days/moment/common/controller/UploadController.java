package com.days.moment.common.controller;


import com.days.moment.common.dto.UploadResponseDTO;
import lombok.extern.log4j.Log4j2;
import net.coobird.thumbnailator.Thumbnailator;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@Log4j2
public class UploadController {

    @GetMapping("/sample/upload")
    public void uploadGet() {

    }

    @ResponseBody
    @PostMapping("/removeFile")
    public ResponseEntity<String> removeFile(@RequestBody Map<String, String> data) throws Exception {

        File file = new File("C:\\upload"+File.separator+data.get("fileName"));

        boolean checkImage = Files.probeContentType(file.toPath()).startsWith("image");

        file.delete();

        if(checkImage){
            File thumbnail = new File(file.getParent(),"s_"+file.getName());
                    log.info(thumbnail);
                    thumbnail.delete();
        }
            return ResponseEntity.ok().body("deleted");
    }



    @GetMapping("/downFile")
    public ResponseEntity<byte[]> download(@RequestParam("file") String fileName) throws Exception {

        File file = new File("C:\\upload"+File.separator+fileName);


        String originalFileName = fileName.substring(fileName.indexOf("_") +1);

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/octet-stream");
        headers.add("Content-Disposition","attachment; filename="
                +new String(originalFileName.getBytes(StandardCharsets.UTF_8),"ISO-8859-1"));
        byte[] data = FileCopyUtils.copyToByteArray(file);
        return ResponseEntity.ok().headers(headers).body(data);

    }


    @GetMapping("/viewFile")
    @ResponseBody
    public ResponseEntity<byte[]> viewFile(@RequestParam("file") String fileName) throws Exception {//보낼땐 file로, 받을떈 fileName이라는 변수로받기위해 사용


        File file = new File("C:\\upload"+File.separator+fileName);

        log.info(file);

        ResponseEntity<byte[]> result = null;

        byte[] data = FileCopyUtils.copyToByteArray(file);


        String mimeType = Files.probeContentType(file.toPath());

        log.info("mimeType:"+mimeType);

        result = ResponseEntity.ok().header("Content-Type",mimeType).body(data);
        return result;
    }


    @ResponseBody
    @PostMapping("/upload")
    public List<UploadResponseDTO> uploadPost(MultipartFile[] uploadFiles) {

        log.info("----");


        if (uploadFiles != null && uploadFiles.length > 0) {

            List<UploadResponseDTO> uploadedList = new ArrayList<>();

            for (MultipartFile multipartFile : uploadFiles) {
                try {
                    uploadedList.add(uploadProcess(multipartFile));
                } catch (Exception e) {
//                    e.printStackTrace();
                }
            }
            return uploadedList;

        }
        return null;
    }

    private UploadResponseDTO uploadProcess(MultipartFile multipartFile) throws Exception{

        String uploadPath = "C:\\upload";

        String folderName = makeFolder(uploadPath);
        String fileName=multipartFile.getOriginalFilename();
        String uuid= UUID.randomUUID().toString();
        String originalFileName = fileName;

        fileName = uuid+"_"+fileName;

        File savedFile = new File(uploadPath+File.separator+folderName, fileName);

        FileCopyUtils.copy(multipartFile.getBytes(), savedFile);

        String mimeType = multipartFile.getContentType();
        boolean checkImage = mimeType.startsWith("image");
        if(checkImage){
            File thumbnailFile = new File(uploadPath+File.separator+folderName, "s_"+fileName);
            Thumbnailator.createThumbnail(savedFile, thumbnailFile, 100,100);
        }

        return UploadResponseDTO.builder()
                .uuid(uuid)
                .uploadPath(folderName.replace(File.separator,"/"))
                .fileName(originalFileName)
                .image(checkImage)
                .build();

    }

    private String makeFolder(String uploadPath){
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String str = simpleDateFormat.format(date);
        String folderName = str.replace("-", File.separator);

        File uploadFolder = new File(uploadPath, folderName);
        if(uploadFolder.exists() == false){
            uploadFolder.mkdirs();
        }
        return folderName;
    }

}
