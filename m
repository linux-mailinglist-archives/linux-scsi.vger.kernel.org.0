Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31D7B140DF0
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Jan 2020 16:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgAQPcK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 17 Jan 2020 10:32:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43711 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgAQPcJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 17 Jan 2020 10:32:09 -0500
Received: by mail-pf1-f193.google.com with SMTP id x6so12109674pfo.10;
        Fri, 17 Jan 2020 07:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vsblHe4BrZXvpcTixylwUCR+Uct1lSaVWajbm+319XI=;
        b=P84BI8hWdgxcB+0kowQ9tTtH+clpCV53/uwgm1fVI3l8tZjFgkNNRf3A3bWGHBpJN1
         L2X6gHUqblk8BNR1ihsyAebJ9nWxkeTvSQXlYM/aorOhx5T5kWXu1H2RSP2jbA1+p2u1
         t1tVDMlGoGu+e++dT6VlGayNKXBK6Y7hnpBCTZ5PXF3rykHUEcgVb/2LROaEmBJPP7q1
         hr9Jwq4PHcB+SOOyvs8L8lFEd1AxMtB4Kji7061vXqQxlAHP6QjGtJH3DdLOG7QqzHxG
         GolP3+EQ6m2rIBo0KTDBekAbZ+vxVLOaBj7OQk5nQiyzvQu5LlaaiMyQv+qLtPew1jkK
         QR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vsblHe4BrZXvpcTixylwUCR+Uct1lSaVWajbm+319XI=;
        b=t6qZlQgXo0GZvY6HX8Luq3PqnUbYU7B0GluCK1WtZCKk2z8ornhATs76/I+CM9AwWW
         0LDVT1FjI2M4NJ4PVIOuTII6dpDRpl0vrZUZFIVqGtDFUCCeHPcxVwZT2iCE8CDmZt8I
         afdYKPb9suewIHroY57+ZzscoUghkQdTK6eHmjFNEG8MF7S1vLy2MD+r0dxrny+b4CHW
         pi3GGJ5PmZy9c651mYGlnRbOkPbMlRcWBvvIHq9dqpr0l1iydibgmHps/K9n6N669Q/O
         9acuh06DRUFbb3SzJhwnPofc7uty2l/uCDYF640tQ9KsyFsoF26WQc4w0b2wqYWdtmLk
         CdkQ==
X-Gm-Message-State: APjAAAX4FphzzmfIcrEaUY/QmAPdXWnsO4sAO0jQw6PrW9x3eQHRgLx4
        PsN5rp2+SJwjUPKC/+DApLg=
X-Google-Smtp-Source: APXvYqyx/DoiLmiFuSGvMMgvwwNgyzCWwMzktxQaXrSFe6BTj7v3p5/Cs7TEnH62gct1Yemj0iRhcg==
X-Received: by 2002:a63:2842:: with SMTP id o63mr46669470pgo.317.1579275129159;
        Fri, 17 Jan 2020 07:32:09 -0800 (PST)
Received: from localhost.localdomain ([103.211.17.168])
        by smtp.googlemail.com with ESMTPSA id d20sm7851020pjs.2.2020.01.17.07.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 07:32:08 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH 2/2] drivers: scsi: qedf: qedf_main: Pass lockdep expression to RCU lists
Date:   Fri, 17 Jan 2020 21:01:24 +0530
Message-Id: <20200117153123.2648-2-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117153123.2648-1-frextrite@gmail.com>
References: <20200117153123.2648-1-frextrite@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

lport->disc.rports is traversed using list_for_each_entry_rcu
outside an RCU read-side critical section but under the protection
of lport->disc.disc_mutex.

Hence, add corresponding lockdep expression to silence false-positive
lockdep warnings, and harden RCU lists.

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 drivers/scsi/qedf/qedf_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index 604856e72cfb..17eab7f8cf05 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -420,7 +420,8 @@ static void qedf_link_recovery(struct work_struct *work)
 	 * ADISC since the rport is in state ready.
 	 */
 	mutex_lock(&lport->disc.disc_mutex);
-	list_for_each_entry_rcu(rdata, &lport->disc.rports, peers) {
+	list_for_each_entry_rcu(rdata, &lport->disc.rports, peers,
+				lockdep_is_held(&lport->disc.disc_mutex)) {
 		if (kref_get_unless_zero(&rdata->kref)) {
 			fc_rport_login(rdata);
 			kref_put(&rdata->kref, fc_rport_destroy);
-- 
2.24.1

