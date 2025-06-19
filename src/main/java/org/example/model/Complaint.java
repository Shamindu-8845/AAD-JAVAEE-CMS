package org.example.model;

import lombok.*;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString

public class Complaint {
    private int complaintId;
    private int employeeId;
    private String title;
    private String description;
    private String status;
    private String remarks;
    private String date;

}
