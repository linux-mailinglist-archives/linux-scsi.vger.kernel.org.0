Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D66364EFD
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Apr 2021 02:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhDTAJa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 19 Apr 2021 20:09:30 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:53850 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhDTAJ1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 19 Apr 2021 20:09:27 -0400
Received: by mail-pj1-f49.google.com with SMTP id nk8so5702572pjb.3
        for <linux-scsi@vger.kernel.org>; Mon, 19 Apr 2021 17:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Xbpf04bJk7wYcO2r0IDvrdD0PIhH0YfN+4ZJKhyqbU=;
        b=kuPsbzJ2GjM5FqF4RLCFdHaRqJAD/FMBqf2zGx6sMHA+YOkExs3zFSdwXhUrFC/kWt
         ygB5K2mUZ5tzGBjmbLBwkZ6jWEOhB6N27iovvRWp+ffxyvD0OVa6G2bvF3pRfhvpNqmI
         M/5HSX/9j8b3841hHkhNkamA+AvLH4XU/p6VECrdvqqkoMxFlWvITaKdwC6LU0z8gxY8
         NuJ6fsBVHIGE6Tk8gQC6TWU4FalLbiDUau4mVCOyt6Uu765/yzExuFTf+x52ed5K05kN
         FedlICU49B/TfM9LuntLhKjXeuAddF2H6hIqdnY4YFoDT5YKfcpG9J6mEwShZTZ/tfgq
         +cLg==
X-Gm-Message-State: AOAM531QjWaUfUAMuC4TiGgd+MmsmSNsEshG01VWH0i53WV/bsjY7rb3
        lcGukkt4EM0Zufswndq89rYHufAXEK4=
X-Google-Smtp-Source: ABdhPJzDrDvFF9rKMDZdoDd/NeuaZ1F2Cr8eGP7JtlFaYrZAaic4OG6NiH5wGnbAuiFhI8Ht34TilA==
X-Received: by 2002:a17:902:c14d:b029:ec:acd9:d5a0 with SMTP id 13-20020a170902c14db02900ecacd9d5a0mr5205316plj.60.1618877336424;
        Mon, 19 Apr 2021 17:08:56 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:3e77:56a4:910b:42a9])
        by smtp.gmail.com with ESMTPSA id 33sm14006787pgq.21.2021.04.19.17.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 17:08:55 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Lee Duncan <lduncan@suse.com>
Subject: [PATCH 004/117] libiscsi: Use the host_status enum
Date:   Mon, 19 Apr 2021 17:06:52 -0700
Message-Id: <20210420000845.25873-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210420000845.25873-1-bvanassche@acm.org>
References: <20210420000845.25873-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Allow the compiler to verify the type of the last argument passed to
fail_scsi_task() and fail_scsi_tasks().

Cc: Lee Duncan <lduncan@suse.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/libiscsi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 7ad11e42306d..4b8c9b9cf927 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -590,7 +590,7 @@ static bool cleanup_queued_task(struct iscsi_task *task)
  * session frwd lock must be held and if not called for a task that is still
  * pending or from the xmit thread, then xmit thread must be suspended
  */
-static void fail_scsi_task(struct iscsi_task *task, int err)
+static void fail_scsi_task(struct iscsi_task *task, enum host_status err)
 {
 	struct iscsi_conn *conn = task->conn;
 	struct scsi_cmnd *sc;
@@ -1885,7 +1885,8 @@ static int iscsi_exec_task_mgmt_fn(struct iscsi_conn *conn,
 /*
  * Fail commands. session frwd lock held and xmit thread flushed.
  */
-static void fail_scsi_tasks(struct iscsi_conn *conn, u64 lun, int error)
+static void fail_scsi_tasks(struct iscsi_conn *conn, u64 lun,
+			    enum host_status error)
 {
 	struct iscsi_session *session = conn->session;
 	struct iscsi_task *task;
