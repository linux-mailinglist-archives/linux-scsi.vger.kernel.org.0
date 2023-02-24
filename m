Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7434C6A1DA4
	for <lists+linux-scsi@lfdr.de>; Fri, 24 Feb 2023 15:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjBXOoj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 Feb 2023 09:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjBXOoa (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 24 Feb 2023 09:44:30 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBBB3B66D
        for <linux-scsi@vger.kernel.org>; Fri, 24 Feb 2023 06:44:20 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id pt11so17321534pjb.1
        for <linux-scsi@vger.kernel.org>; Fri, 24 Feb 2023 06:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3WeSU6gZasLUpJzkk9fvjfeVVHV2/KW6jsS+WwJRaRQ=;
        b=hP5C3YLCocPlC3nfUqCwe7fbqsKLFCUy2oKB9S4GiZ4Mp4RJkezQJmbPcVbKLS0sl4
         O9Zq7qNw/qfBRtsUFauWf/4kiHSAitnvAvB7GptdeBjRW59Rux3WtsFe6QMPC0DoRJFM
         lVGB+hZQGQ5nHKEVFpMZIobxr+cmN8jMkJ5Ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3WeSU6gZasLUpJzkk9fvjfeVVHV2/KW6jsS+WwJRaRQ=;
        b=r/3xSjJaMjWWL5alZs5dxsNkMdavAlw7HxZnt0zkWz3KHUqkzmiqBfVmMY1RPdGr39
         y/FF8AdI93n545Brxs2XWm5HmO7llH0gcocPQ9wpnlsjtwiwL1wgSK4XjjWh99fD8lm3
         vvqOhcguRVEKSjzTgY2rLoQAxRtIehAh6MvampOjIKATCzDVG07rqQvHvtEuGTyAnABk
         Pgt8FUDFcq0u3YO1TmYmbQq1qG/3Rh0CVMolKeqC984zHGLcUW1plS4GZRk/pC3Sf3bG
         IE6rRn2ny81mj6M+z2zkNkUBsWdTA+ExcRxQqFDbhKf15LFe5hIEU6WeUC8pqoQaf/nM
         ST+A==
X-Gm-Message-State: AO0yUKX2j234V4U1fqu6YxbEgYqf7ewabaTuWAwldenZVNYvf4KWSaTf
        35/IgJTJMmBnbeRXPuerL1CIBhRoDbg4m82YvS41Yyop+csRnnKyqwlOj0DfiNYdiht5oZN0EhM
        U+8WBXgF2vgvzMnt9u9nK1ucRRhYrQcHZhECl4ns2YiO6cTsjY6IpdqlMZNgNoxfsacRB6zjsct
        8xVO6Kpcg=
X-Google-Smtp-Source: AK7set972032X4+ajFJFMGrlZYSmFrH+dggZzkB655c4Lw3toFm98CWzwGULGEQe/hNlqocQ/Ds9oQ==
X-Received: by 2002:a17:903:2845:b0:19c:c9da:a62e with SMTP id kq5-20020a170903284500b0019cc9daa62emr3451097plb.54.1677249859065;
        Fri, 24 Feb 2023 06:44:19 -0800 (PST)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902a9c500b00186748fe6ccsm8911549plr.214.2023.02.24.06.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 06:44:18 -0800 (PST)
From:   Ranjan Kumar <ranjan.kumar@broadcom.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Cc:     rajsekhar.chundru@broadcom.com, sathya.prakash@broadcom.com,
        sumit.saxena@broadcom.com,
        Ranjan Kumar <ranjan.kumar@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Subject: [PATCH 07/15] mpi3mr: IOCTL timeout when disable/enable Interpt
Date:   Fri, 24 Feb 2023 06:43:12 -0800
Message-Id: <20230224144320.10601-8-ranjan.kumar@broadcom.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230224144320.10601-1-ranjan.kumar@broadcom.com>
References: <20230224144320.10601-1-ranjan.kumar@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000013926105f5732af8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--00000000000013926105f5732af8
Content-Transfer-Encoding: 8bit

As part of Task Management handling, the driver will disable and
enable the MSIx index zero which belongs to the Admin reply queue. And
while enabling the interrupts driver loses some interrupts and it
leads to Admin requests such as IOCTL timeout. So, after enabling the
interrupts, poll the Admin reply queue to avoid timeouts.

Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
---
 drivers/scsi/mpi3mr/mpi3mr.h    |  3 +++
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 12 ++++++++++--
 drivers/scsi/mpi3mr/mpi3mr_os.c |  1 +
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index 1cfbf39365d2..258ad9d5ac90 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -904,6 +904,7 @@ struct scmd_priv {
  * @admin_reply_ephase:Admin reply queue expected phase
  * @admin_reply_base: Admin reply queue base virtual address
  * @admin_reply_dma: Admin reply queue base dma address
+ * @admin_reply_q_in_use: Queue is handled by poll/ISR
  * @ready_timeout: Controller ready timeout
  * @intr_info: Interrupt cookie pointer
  * @intr_info_count: Number of interrupt cookies
@@ -1060,6 +1061,7 @@ struct mpi3mr_ioc {
 	u8 admin_reply_ephase;
 	void *admin_reply_base;
 	dma_addr_t admin_reply_dma;
+	atomic_t admin_reply_q_in_use;
 
 	u32 ready_timeout;
 
@@ -1398,4 +1400,5 @@ void mpi3mr_add_event_wait_for_device_refresh(struct mpi3mr_ioc *mrioc);
 void mpi3mr_flush_drv_cmds(struct mpi3mr_ioc *mrioc);
 void mpi3mr_flush_cmds_for_unrecovered_controller(struct mpi3mr_ioc *mrioc);
 void mpi3mr_free_enclosure_list(struct mpi3mr_ioc *mrioc);
+int mpi3mr_process_admin_reply_q(struct mpi3mr_ioc *mrioc);
 #endif /*MPI3MR_H_INCLUDED*/
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 83e145494067..e9b3552ccafb 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -415,7 +415,7 @@ static void mpi3mr_process_admin_reply_desc(struct mpi3mr_ioc *mrioc,
 		    le64_to_cpu(scsi_reply->sense_data_buffer_address));
 }
 
-static int mpi3mr_process_admin_reply_q(struct mpi3mr_ioc *mrioc)
+int mpi3mr_process_admin_reply_q(struct mpi3mr_ioc *mrioc)
 {
 	u32 exp_phase = mrioc->admin_reply_ephase;
 	u32 admin_reply_ci = mrioc->admin_reply_ci;
@@ -423,12 +423,17 @@ static int mpi3mr_process_admin_reply_q(struct mpi3mr_ioc *mrioc)
 	u64 reply_dma = 0;
 	struct mpi3_default_reply_descriptor *reply_desc;
 
+	if (!atomic_add_unless(&mrioc->admin_reply_q_in_use, 1, 1))
+		return 0;
+
 	reply_desc = (struct mpi3_default_reply_descriptor *)mrioc->admin_reply_base +
 	    admin_reply_ci;
 
 	if ((le16_to_cpu(reply_desc->reply_flags) &
-	    MPI3_REPLY_DESCRIPT_FLAGS_PHASE_MASK) != exp_phase)
+	    MPI3_REPLY_DESCRIPT_FLAGS_PHASE_MASK) != exp_phase) {
+		atomic_dec(&mrioc->admin_reply_q_in_use);
 		return 0;
+	}
 
 	do {
 		if (mrioc->unrecoverable)
@@ -454,6 +459,7 @@ static int mpi3mr_process_admin_reply_q(struct mpi3mr_ioc *mrioc)
 	writel(admin_reply_ci, &mrioc->sysif_regs->admin_reply_queue_ci);
 	mrioc->admin_reply_ci = admin_reply_ci;
 	mrioc->admin_reply_ephase = exp_phase;
+	atomic_dec(&mrioc->admin_reply_q_in_use);
 
 	return num_admin_replies;
 }
@@ -2608,6 +2614,7 @@ static int mpi3mr_setup_admin_qpair(struct mpi3mr_ioc *mrioc)
 	mrioc->admin_reply_ci = 0;
 	mrioc->admin_reply_ephase = 1;
 	mrioc->admin_reply_base = NULL;
+	atomic_set(&mrioc->admin_reply_q_in_use, 0);
 
 	if (!mrioc->admin_req_base) {
 		mrioc->admin_req_base = dma_alloc_coherent(&mrioc->pdev->dev,
@@ -4171,6 +4178,7 @@ void mpi3mr_memset_buffers(struct mpi3mr_ioc *mrioc)
 		memset(mrioc->admin_req_base, 0, mrioc->admin_req_q_sz);
 	if (mrioc->admin_reply_base)
 		memset(mrioc->admin_reply_base, 0, mrioc->admin_reply_q_sz);
+	atomic_set(&mrioc->admin_reply_q_in_use, 0);
 
 	if (mrioc->init_cmds.reply) {
 		memset(mrioc->init_cmds.reply, 0, sizeof(*mrioc->init_cmds.reply));
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index e4ae246f4bd2..4fe2102ef331 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -3719,6 +3719,7 @@ int mpi3mr_issue_tm(struct mpi3mr_ioc *mrioc, u8 tm_type,
 		mpi3mr_poll_pend_io_completions(mrioc);
 		mpi3mr_ioc_enable_intr(mrioc);
 		mpi3mr_poll_pend_io_completions(mrioc);
+		mpi3mr_process_admin_reply_q(mrioc);
 	}
 	switch (tm_type) {
 	case MPI3_SCSITASKMGMT_TASKTYPE_TARGET_RESET:
-- 
2.31.1


--00000000000013926105f5732af8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
GK2Ee6ez7fr/FL1RWbOPVHJR+deNIorOjW7U5HVwnRYhM1OR4mAkrkqcN+3kwae0KmVO3SDKFd7h
Ok4L2e1ixyaRTo379Ur3iVTnagglDOliayMGRITBPe0CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcmFuamFuLmt1bWFyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU8WuEiYXvpeCaubgLCCFoyRBc
8QwwDQYJKoZIhvcNAQELBQADggEBAA5th3yz1fvJCBmK21x68IdDNFC0gmynT76I3fOgslLHc7ey
lC9VXLb+vJ863blS/WxEOwf0fvc0ks7qYWl8xisInHu5AX9glaooGhLImlzE0l9rDf0tcq2kkgc4
CXL9UGDEoqdxfRj3j9xn9fm9gpTBWSck6ufc/8RV1TLVjcZvrYkMqQwoVulGkr+HCnzaEFxBRmO/
nWsVitGa1sKS9usFXoW1bQXgJ9TtRdy8gka8b9SaKnh4TaiEKpdl8ztXhugWp7RpFGVu/ZZ8narx
0H1L9W/UIr3J/uYokdFr+hIrXOfOwJLB18bWOTCVWxTEo4zYC8qZ/h7UcS5aispm/rkxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxMV+PqteWF5WGw7jsw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIWYGeUtR/KAMSp/umDFqIY0QunykMC9
3WJkqjIP0lfcMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDIy
NDE0NDQxOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQADleTlRwpJ80HZ0Z5xTs6BXZ3UD+gKS4XLNwC538/B09SD2ElB
NlOIfUjG8z8PlFc4OhlN47EVANuxX/bpmokTYRH2TRlcqJvWUMCPdRZn1D765e90yA/HZxCUNPPt
0mkNv+XZBYwGvYPEBWb8dOA7gkemOs7H3WyTHddA6M++aJ4lXbC6eDyD+oRo4lNc51NYPjfy55zR
kacN+Mok4dLgw83bdYYIWbCYmEEKhIgDsjfayiOi1eiT8PNFVVzxTkhxBLmm9XjCr4vZ9fcc64Qw
gYmeWC+mfFEEItaxvLWa5GzqdQZD8UyJqLoc8xQLm1cprTPnht1QsVBwp834yfih
--00000000000013926105f5732af8--
