Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5C23812F1
	for <lists+linux-scsi@lfdr.de>; Fri, 14 May 2021 23:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbhENVfk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 May 2021 17:35:40 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:46729 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbhENVfi (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 14 May 2021 17:35:38 -0400
Received: by mail-pj1-f46.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso456516pjb.5
        for <linux-scsi@vger.kernel.org>; Fri, 14 May 2021 14:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gqOY8NOf3A/uVe1kfrH5HeRCTEoAD33kBspCQvlgDPI=;
        b=OhMJGII7ygEDgpt7AUqLCV2HvRfEtAD6FzzszVR48ZeCYDiQLxb8z2CE80CRFONwXi
         mNFM/RVvdtzIs71VKlMsjIdNrw5PdwP+FNcvctLdNmXADJHlrwl5EbfZdLFkujLswv7J
         lvcNZKCdXhpMJmEwMMGiLIVr14KAPXad3Tk2yI0Teln2CjINnA+IZLrFzcdqe1Nkckpt
         5B2hJ/J7IRKoxD3QC4vxRr993tilxmVFepx5tQGpxKpOqsojIEdKIXVIxHD1iUB28E7x
         UoxlMMCPf/A4005u4+Yw8EGySILwTITJoOyLv7jCNrkw/A2Xpr55OTlNFswKtrM7m8sD
         2eoQ==
X-Gm-Message-State: AOAM531SRQ4XtB0mxsSSGYVrz8qHi98Ujtm/nLFC+nux9OnjiibwnZyi
        FDtBApVpt5OOUFMkF3LPs+Y=
X-Google-Smtp-Source: ABdhPJzPtP+F6aMxFcJjH+ahASvtNCr3uE/jGa8o2VS5fbMSk1SMk1xpY0JdsDUsv6d/BhWJGGDyfg==
X-Received: by 2002:a17:902:e051:b029:ed:7646:49c4 with SMTP id x17-20020a170902e051b02900ed764649c4mr47632565plx.55.1621028065209;
        Fri, 14 May 2021 14:34:25 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:e40c:c579:7cd8:c046])
        by smtp.gmail.com with ESMTPSA id js6sm9307262pjb.0.2021.05.14.14.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 14:34:24 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH 12/50] NCR5380: Use blk_req() instead of scsi_cmnd.request
Date:   Fri, 14 May 2021 14:32:27 -0700
Message-Id: <20210514213356.5264-13-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210514213356.5264-1-bvanassche@acm.org>
References: <20210514213356.5264-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Prepare for removal of the request pointer by using blk_req() instead. This
patch does not change any functionality.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/NCR5380.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index 2ddbcaa667d1..cfeadbd98669 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -778,7 +778,7 @@ static void NCR5380_dma_complete(struct Scsi_Host *instance)
 	}
 
 #ifdef CONFIG_SUN3
-	if ((sun3scsi_dma_finish(rq_data_dir(hostdata->connected->request)))) {
+	if ((sun3scsi_dma_finish(rq_data_dir(blk_req(hostdata->connected))))) {
 		pr_err("scsi%d: overrun in UDC counter -- not prepared to deal with this!\n",
 		       instance->host_no);
 		BUG();
@@ -1710,7 +1710,7 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
 				count = sun3scsi_dma_xfer_len(hostdata, cmd);
 
 				if (count > 0) {
-					if (rq_data_dir(cmd->request))
+					if (rq_data_dir(blk_req(cmd)))
 						sun3scsi_dma_send_setup(hostdata,
 						                        cmd->SCp.ptr, count);
 					else
@@ -2158,7 +2158,7 @@ static void NCR5380_reselect(struct Scsi_Host *instance)
 		count = sun3scsi_dma_xfer_len(hostdata, tmp);
 
 		if (count > 0) {
-			if (rq_data_dir(tmp->request))
+			if (rq_data_dir(blk_req(tmp)))
 				sun3scsi_dma_send_setup(hostdata,
 				                        tmp->SCp.ptr, count);
 			else
