Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A544168C9
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 19:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfEGRHL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 13:07:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36312 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGRHL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 13:07:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id v80so8976552pfa.3
        for <linux-scsi@vger.kernel.org>; Tue, 07 May 2019 10:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EzayKxQXuN2dwrBvykQbKk1qVbnmwjIJaXQycA6LH0Y=;
        b=B2v1xBarizmRfl7vhWrxk/zPa9t7lmcpHXVY9XbG2iWIJ9FdyxWGYvPfdSwJF01a/9
         mg1hFvjsfvSMGOo727C8zvWzTmCZdZXwlAVlgffylz1t6gVu6YYeKGTEQKLBUMRGHBF7
         UZdTU8hMC947wAIN3PJF1AXpULEulsAK8PCjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EzayKxQXuN2dwrBvykQbKk1qVbnmwjIJaXQycA6LH0Y=;
        b=Cbw0b2Iqje5esLrkPa6V69xsSdsV+50SdKqdui7qPOjXttl/AGDtTJ63PugHEZC8zd
         XXMHl9mAD2G9NB30OrBGj3NqYhuq7EdPYewB1Iij/Eny7PW6QKYozNbmHrRY7AixhUpl
         GiLp/8nUoF3JNmjEPBrqk+O7bNZTdsvCwZ96wQmv3bU3aMJ6cEzqrTb6+LQPNfkH84iQ
         huiOPktAb4fU6vrbVoGcttJGyUhR8PaY8Qkh6k371QoBsZzKZI0i5nLOtAGiDq7u2P3R
         4h7jreUceT0V2i0r+Ben+yTxvSki1fKVcv/tTYloUyhi+aDkPAJN/gXqYeS5kCTg1ear
         az3Q==
X-Gm-Message-State: APjAAAU8okqIzQ7jUZDDiUAeM9dXULn8eQgDlIXeIytfgqwBSLL2D0D9
        WzUYtHSsU1jdfOHXMgA/jirDwMkt3WXtEzVCzkJAur00OyGgrG8zSwWxPbx15aXrG6sF2wPI6cq
        2WLV3v1E5ExNXhCDrJRDuQCLopxnqkTMJP7YTMtNwnV9n8LPabIQo5p5dPUwkmR9gfUYzgdAvQL
        23FFGnhHckl4+IPOAh0fC5
X-Google-Smtp-Source: APXvYqz6MCTjFFtgVtanja47p/VlkREzdW0iIYlzsNC7OZwVIkoa0TxaE8PGhw8T2mQmoSoOysHNnw==
X-Received: by 2002:a62:575b:: with SMTP id l88mr42053149pfb.143.1557248830031;
        Tue, 07 May 2019 10:07:10 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r74sm17527791pfa.71.2019.05.07.10.07.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:07:09 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH v2 17/21] megaraid_sas: Add prints in suspend and resume path
Date:   Tue,  7 May 2019 10:05:46 -0700
Message-Id: <1557248750-4099-18-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add prints in resume/suspend path to help in debugging
hibernation issues. The print gives an indication when the driver
entry points are called.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 4689909fa66b..b40702e30e49 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -7244,6 +7244,8 @@ megasas_suspend(struct pci_dev *pdev, pm_message_t state)
 	host = instance->host;
 	instance->unload = 1;
 
+	dev_info(&pdev->dev, "%s is called\n", __func__);
+
 	/* Shutdown SR-IOV heartbeat timer */
 	if (instance->requestorId && !instance->skip_heartbeat_timer_del)
 		del_timer_sync(&instance->sriov_heartbeat_timer);
@@ -7298,6 +7300,7 @@ megasas_resume(struct pci_dev *pdev)
 	pci_enable_wake(pdev, PCI_D0, 0);
 	pci_restore_state(pdev);
 
+	dev_info(&pdev->dev, "%s is called\n", __func__);
 	/*
 	 * PCI prepping: enable device set bus mastering and dma mask
 	 */
-- 
2.16.1

