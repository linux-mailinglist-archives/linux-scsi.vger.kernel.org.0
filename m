Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1D9F2E616
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 22:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfE2U2m (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 16:28:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33742 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2U2m (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 16:28:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id z28so2383230pfk.0
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 13:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7A0umEKG1XTfCvUEPhQf1m81zHAhE8jtDQjRU0sGDcc=;
        b=kgQALcG2SQzFFcIBt3H8U4ZyIo0ni2lCARW39qrdinz4HcvCrLssELvVxg/vhb56Lq
         JsTDnnECO0k+IcIOy6V85KLByGdWwB87Hai/MNSod5AfBlLbGcde/CdVsWgSdLK8FcZ+
         LXmh1ZqVHEZyveokV+7nyIr6dwtjzLh6tzZ3o0GZvDiD66FBButmrvYY3ZMCz2DwyIZr
         YUdIqtEGpZIrHEilgiSvPM2kUAfhtI8OniXFEk/Gbn6AZNXwOu+FVwauS4m8lyLL+uzs
         PWoxXOpDXjrf9QYK8TpBk6+87NZztV1U+d3hyZ1G38QJY5fABipKANMDeqo9gXIARIuB
         oFUg==
X-Gm-Message-State: APjAAAVUA/Ot++W2RKMeAJ534+w/q0Yp8+x7sHqCUbI0U/WJqiLxeaID
        EyLg8ahxawF6sKQVXBz231k=
X-Google-Smtp-Source: APXvYqwvvaMPfsIgkvGhdo8vda2n/8o4kt7j3SuALB6pEGYZLndf2fkZaXF0XBFgIdlsL8Sv7mtWSg==
X-Received: by 2002:a17:90a:30a1:: with SMTP id h30mr1055907pjb.14.1559161721502;
        Wed, 29 May 2019 13:28:41 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y12sm239229pgi.10.2019.05.29.13.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:28:40 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 03/20] qla2xxx: Remove an include directive from qla_mr.c
Date:   Wed, 29 May 2019 13:28:09 -0700
Message-Id: <20190529202826.204499-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190529202826.204499-1-bvanassche@acm.org>
References: <20190529202826.204499-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

There is no bsg code in the qla_mr.c source file. Hence do not include
the <linux/bsg-lib.h> header file from qla_mr.c.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_mr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_mr.c b/drivers/scsi/qla2xxx/qla_mr.c
index 942ee13b96a4..cd892edec4dc 100644
--- a/drivers/scsi/qla2xxx/qla_mr.c
+++ b/drivers/scsi/qla2xxx/qla_mr.c
@@ -10,7 +10,6 @@
 #include <linux/pci.h>
 #include <linux/ratelimit.h>
 #include <linux/vmalloc.h>
-#include <linux/bsg-lib.h>
 #include <scsi/scsi_tcq.h>
 #include <linux/utsname.h>
 
-- 
2.22.0.rc1

