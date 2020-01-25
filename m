Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF6D91496E5
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Jan 2020 18:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgAYR3C (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 25 Jan 2020 12:29:02 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42476 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgAYR3C (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 25 Jan 2020 12:29:02 -0500
Received: by mail-pg1-f194.google.com with SMTP id s64so2863060pgb.9;
        Sat, 25 Jan 2020 09:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MB/ErMiDCqzWRhbWQz8sgwwpA/uNzcXhw/DsIF3UwFs=;
        b=O9R3zvYSJE6wfmayHhWS5f4KuyT9d8QzC5nzWN/ZTM3xgFuk0/qKvNrdHRhuP9vUNM
         TMoHW/GxgRu2FqMaQI6KGdSBunQOpbroXqXwxdjy/wvnvx4YwO82tujf+syNHMo8PN5u
         fR0aXoOC+Pe0WxX/rZut9CbdTagNipMD30ToDeXTVM5oQAEjmcwrqe1yjv8HZa7V5ELg
         TnHLy4zsTLnUtzrQMfkkWGizPd5N/hZphQiMEz4G+uDt62zS20cRlGximu/G7Ck88hY5
         SRfzYRS8/MozssZFoKqb078osZEjoauYYsZt2vjKkylPlqmK/LDvS+rGIPIkCMSgJTBP
         xUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MB/ErMiDCqzWRhbWQz8sgwwpA/uNzcXhw/DsIF3UwFs=;
        b=tzbI+gUMiDia+tDUkiPWq++WftpI5lx6mZHMuAqmlxc3tMY7MohpQtnJrERArVC/V6
         d/d2WD4lTJ6d99tkJcvZ7jYRAuCgr3nTNf3o/GgIDv6TmCPPjHZt+M6xGx5FyEfehWUt
         PisHrYrfc4gKzVx2u3m7m50d7/Nu0CvLIydjDu9SwBhejKvgshtmqMRN1RW0jOWSQ28W
         va3Yfw4nBngedDqqcvZRkDC2WB1fNY+CaRuU07lgE9ZwVcEMAtW4CW3UePzkJ7ELqkl+
         m57atOaBJLyZRxb6liAIz2OCSPllfLKv54IOOZWs5y7JsP+O6W69xFwsBniJAZvgwRHa
         e9aA==
X-Gm-Message-State: APjAAAW583/cdo7K82XAYJFhNRdMGdDrzSamxR6QqODWEM6+MQUqT0en
        5xXs+nZ4u7w3AAbzTURqscxVemGrzmlYPQ==
X-Google-Smtp-Source: APXvYqy1qAaj9dVf+YEWjJtRBsYo521UD7GSiezx4uuBlKbUr3m9zyJ8m8X0HazPG0tpOyDSmv+Drw==
X-Received: by 2002:aa7:83d6:: with SMTP id j22mr8969303pfn.122.1579973341692;
        Sat, 25 Jan 2020 09:29:01 -0800 (PST)
Received: from google.com ([123.201.163.48])
        by smtp.gmail.com with ESMTPSA id p18sm13123682pjo.3.2020.01.25.09.28.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 25 Jan 2020 09:29:01 -0800 (PST)
Date:   Sat, 25 Jan 2020 22:58:54 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     intel-linux-scu@intel.com, artur.paszkiewicz@intel.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] scsi: isci: fix unneeded variable
Message-ID: <20200125172854.GA4860@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.6.2-neo (NetBSD/sparc64)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

remove unneeded variable status in request.c file.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
  drivers/scsi/isci/request.c | 8 +++-----
  1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/isci/request.c b/drivers/scsi/isci/request.c
index 343d24c..9849366 100644
--- a/drivers/scsi/isci/request.c
+++ b/drivers/scsi/isci/request.c
@@ -1480,7 +1480,6 @@ static enum sci_status sci_stp_request_pio_data_in_copy_data(
  stp_request_pio_await_h2d_completion_tc_event(struct isci_request *ireq,
  					      u32 completion_code)
  {
-	enum sci_status status = SCI_SUCCESS;
  
  	switch (SCU_GET_COMPLETION_TL_STATUS(completion_code)) {
  	case SCU_MAKE_COMPLETION_STATUS(SCU_TASK_DONE_GOOD):
@@ -1500,7 +1499,7 @@ static enum sci_status sci_stp_request_pio_data_in_copy_data(
  		break;
  	}
  
-	return status;
+	return SCI_SUCCESS;
  }
  
  static enum sci_status
@@ -2148,13 +2147,12 @@ static enum sci_status stp_request_udma_await_tc_event(struct isci_request *ireq
  		break;
  	}
  
-	return status;
+	return SCI_SUCCESS;
  }
  
  static enum sci_status atapi_raw_completion(struct isci_request *ireq, u32 completion_code,
  						  enum sci_base_request_states next)
  {
-	enum sci_status status = SCI_SUCCESS;
  
  	switch (SCU_GET_COMPLETION_TL_STATUS(completion_code)) {
  	case SCU_MAKE_COMPLETION_STATUS(SCU_TASK_DONE_GOOD):
@@ -2174,7 +2172,7 @@ static enum sci_status atapi_raw_completion(struct isci_request *ireq, u32 compl
  		break;
  	}
  
-	return status;
+	return SCI_SUCCESS;
  }
  
  static enum sci_status atapi_data_tc_completion_handler(struct isci_request *ireq,
-- 
1.9.1

