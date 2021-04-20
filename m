Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52204364F01
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Apr 2021 02:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhDTAJe (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 19 Apr 2021 20:09:34 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:35749 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbhDTAJb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 19 Apr 2021 20:09:31 -0400
Received: by mail-pj1-f47.google.com with SMTP id j21-20020a17090ae615b02901505b998b45so6027678pjy.0
        for <linux-scsi@vger.kernel.org>; Mon, 19 Apr 2021 17:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Nc3VVLReBY36ALtGRnoKcNqPsoRmOZjwWE4grVnGkc=;
        b=LpbNqJ0Yx7h5q0zAJKTOcwtvAm1hNyVMXgztQHQ9yq5Zwq3TmctLcT7iXDgTuArjkY
         KfQOqiJouTAPOxnNSLLk1Mz590BJl/+1PSAhTkxX4jxd3gluzhS+k3WcbsD3/fjHmb9B
         3wdPOwVLg5uA3mD8Ts7EhhGIGRDfazFJzoYDt0Cxf0Vd/3owEVxU73FuEDmoEVedaAHr
         7NU54A7WNzsBMqM8ZURxdt1B5Ek5V3UMPEoNVQMOCNA4Pl2yPiUD9WD5mbtr7w3ii5ew
         hu0xtZMRlUK3eH+Nd2lcytuI5BsFaoEsX8p+VUAv7iiXC85ujQvZF6tvUxEee2f0SVfJ
         pUiQ==
X-Gm-Message-State: AOAM531cGXEpN+49W7lAVHf8SfSrspAurcuBDDUNmGuVjgkIYV85eTuM
        hnod4KgpwYLnAGcu+K4qblA=
X-Google-Smtp-Source: ABdhPJwzKxohRVfG4GxGR5RKOz1s00LHTtR4ZNaCf/4SpR/oDSVruktWWG8iCsS/LxqnjM0Ddoeh8A==
X-Received: by 2002:a17:90a:e00f:: with SMTP id u15mr1776379pjy.26.1618877340944;
        Mon, 19 Apr 2021 17:09:00 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:3e77:56a4:910b:42a9])
        by smtp.gmail.com with ESMTPSA id 33sm14006787pgq.21.2021.04.19.17.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 17:09:00 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        James Smart <james.smart@broadcom.com>
Subject: [PATCH 008/117] fc: Add a compile-time structure size check
Date:   Mon, 19 Apr 2021 17:06:56 -0700
Message-Id: <20210420000845.25873-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210420000845.25873-1-bvanassche@acm.org>
References: <20210420000845.25873-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Before changing the definition of struct fc_bsg_reply, add a compile-time
structure size check.

Cc: James Smart <james.smart@broadcom.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_transport_fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index da5b503dc7a1..2d4db2ae45db 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -948,6 +948,8 @@ static __init int fc_transport_init(void)
 {
 	int error;
 
+	BUILD_BUG_ON(offsetof(struct fc_bsg_reply, reply_data) != 8);
+
 	atomic_set(&fc_event_seq, 0);
 
 	error = transport_class_register(&fc_host_class);
