package com.mycompany.applicationone.web;


import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import static org.hamcrest.Matchers.*;
import static org.hamcrest.Matchers.emptyString;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.header;

@AutoConfigureMockMvc
@SpringBootTest
public class webRequestsTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void testTheEndpoint() throws Exception {
        mockMvc.perform(get("/api/v1/welcome"))
                .andExpect(status().isOk())
                .andExpect(content().string("Welcome to the world of Azure Containers!"));
    }
}
