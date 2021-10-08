Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2631427203
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Oct 2021 22:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242443AbhJHU0H (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 8 Oct 2021 16:26:07 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:40768 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242366AbhJHU0B (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 8 Oct 2021 16:26:01 -0400
Received: by mail-pf1-f176.google.com with SMTP id o133so2844237pfg.7
        for <linux-scsi@vger.kernel.org>; Fri, 08 Oct 2021 13:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/VigYoDqQaVLh8ZnJ8MkI1sXa+kkie0GLhmAN4WYaIg=;
        b=VAZJWlueH2pv8Sq32gR9b/lA7hHFaEY1ZTu2GFlWrI+ddtIufmed9hAuGoUdiDZRio
         GvX4viE5j16zpclFRWcjYPwXlP25J5uhpZAD6cczFgB2AjzGlp0scPNGk65yZPp+VIsv
         NeDJsj00P5AsnhrlA/PS7h2NTMMaF873iRcNlxOQ9Y9ZhwKV65+92hhcDxoQJfljgc+3
         WpsZhjWBNMdXcUWJ3JnueWTvXJIhySS2k898e2ieNmu/DVs4JVpbMOhpiwEgbQEi048N
         Xbw4P8u59m9FJNqLtldaAuRRn/h4clb+VqaqQvpx2rCa6vQO9QNP34nAtOCV3BtGdQQ5
         5vYg==
X-Gm-Message-State: AOAM532rdyJAjmcPwCUiuQsik07hhVZseWv4k5j4QkE6xpenjaoJCU9O
        9JApD0xALWuCfSG+T5NOSZE=
X-Google-Smtp-Source: ABdhPJz3A5uXkE3XzWbs8q+H3JlSX4dBfI91PGd88W8NVfe8QeLaPV1OxRcmOXOV25RZ/YDF/2o90A==
X-Received: by 2002:a63:dd45:: with SMTP id g5mr6378811pgj.236.1633724645930;
        Fri, 08 Oct 2021 13:24:05 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:a8e9:7950:57f8:970])
        by smtp.gmail.com with ESMTPSA id x21sm170858pfa.186.2021.10.08.13.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 13:24:05 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v3 04/46] RDMA/srp: Switch to attribute groups
Date:   Fri,  8 Oct 2021 13:23:11 -0700
Message-Id: <20211008202353.1448570-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
In-Reply-To: <20211008202353.1448570-1-bvanassche@acm.org>
References: <20211008202353.1448570-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

struct device supports attribute groups directly but does not support
struct device_attribute directly. Hence switch to attribute groups.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 51 +++++++++++++++++------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 71eda91e810c..089e09bfe002 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1026,10 +1026,17 @@ static int srp_init_cmd_priv(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
  */
 static void srp_del_scsi_host_attr(struct Scsi_Host *shost)
 {
-	struct device_attribute **attr;
+	const struct attribute_group **g;
+	struct attribute **attr;
 
-	for (attr = shost->hostt->shost_attrs; attr && *attr; ++attr)
-		device_remove_file(&shost->shost_dev, *attr);
+	for (g = shost->hostt->shost_groups; *g; ++g) {
+		for (attr = (*g)->attrs; *attr; ++attr) {
+			struct device_attribute *dev_attr =
+				container_of(*attr, typeof(*dev_attr), attr);
+
+			device_remove_file(&shost->shost_dev, dev_attr);
+		}
+	}
 }
 
 static void srp_remove_target(struct srp_target_port *target)
@@ -3050,26 +3057,28 @@ static ssize_t allow_ext_sg_show(struct device *dev,
 
 static DEVICE_ATTR_RO(allow_ext_sg);
 
-static struct device_attribute *srp_host_attrs[] = {
-	&dev_attr_id_ext,
-	&dev_attr_ioc_guid,
-	&dev_attr_service_id,
-	&dev_attr_pkey,
-	&dev_attr_sgid,
-	&dev_attr_dgid,
-	&dev_attr_orig_dgid,
-	&dev_attr_req_lim,
-	&dev_attr_zero_req_lim,
-	&dev_attr_local_ib_port,
-	&dev_attr_local_ib_device,
-	&dev_attr_ch_count,
-	&dev_attr_comp_vector,
-	&dev_attr_tl_retry_count,
-	&dev_attr_cmd_sg_entries,
-	&dev_attr_allow_ext_sg,
+static struct attribute *srp_host_attrs[] = {
+	&dev_attr_id_ext.attr,
+	&dev_attr_ioc_guid.attr,
+	&dev_attr_service_id.attr,
+	&dev_attr_pkey.attr,
+	&dev_attr_sgid.attr,
+	&dev_attr_dgid.attr,
+	&dev_attr_orig_dgid.attr,
+	&dev_attr_req_lim.attr,
+	&dev_attr_zero_req_lim.attr,
+	&dev_attr_local_ib_port.attr,
+	&dev_attr_local_ib_device.attr,
+	&dev_attr_ch_count.attr,
+	&dev_attr_comp_vector.attr,
+	&dev_attr_tl_retry_count.attr,
+	&dev_attr_cmd_sg_entries.attr,
+	&dev_attr_allow_ext_sg.attr,
 	NULL
 };
 
+ATTRIBUTE_GROUPS(srp_host);
+
 static struct scsi_host_template srp_template = {
 	.module				= THIS_MODULE,
 	.name				= "InfiniBand SRP initiator",
@@ -3090,7 +3099,7 @@ static struct scsi_host_template srp_template = {
 	.can_queue			= SRP_DEFAULT_CMD_SQ_SIZE,
 	.this_id			= -1,
 	.cmd_per_lun			= SRP_DEFAULT_CMD_SQ_SIZE,
-	.shost_attrs			= srp_host_attrs,
+	.shost_groups			= srp_host_groups,
 	.track_queue_depth		= 1,
 	.cmd_size			= sizeof(struct srp_request),
 };
