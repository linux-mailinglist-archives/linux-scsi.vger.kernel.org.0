Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6110E15A1DD
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Feb 2020 08:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgBLHXq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 12 Feb 2020 02:23:46 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44114 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgBLHXq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 12 Feb 2020 02:23:46 -0500
Received: by mail-pg1-f196.google.com with SMTP id g3so597824pgs.11;
        Tue, 11 Feb 2020 23:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=sSs36sQnxGTfCuz7UN6u9y3waBifKuK+zZ5r4rWQl60=;
        b=oxVdvJbpI1X86ZupSuF4fCCHh+VlIFzg0QuIchF1F8Njm3jM6YS3bgcGYc3tMmJUtj
         0dY2OWYizLldYRAF3MUfzDF+zSm+bnim1+dDYY2k1a3JvG383nyFfMMLm2yiiFtnIrUb
         q2/gx7A+fTMuyvZCD4e31RC4BE18ZrXePmBYX5dn4KE0n/Qa45iYJgrQivYVkwmD3yH5
         iiQH2Yl0JfvPr1YBNks97L97Z3o/f0kE9JGU7wHrjO/X+8G2jQ3IEAYrkEVW2Cc9VEYq
         ixOxCWE4q5ekznrz1Y8s83snb7YkWP2zWmnQCT8q2CbydlM7y/xyo/+7aWsGElBj22Is
         ZeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=sSs36sQnxGTfCuz7UN6u9y3waBifKuK+zZ5r4rWQl60=;
        b=Qhf+7eGC3hf9DBcQGiFqVJk/5rhFR6j1drXg201qulv0zHsoFoQaZt554AMtncM8oF
         eK2ed+LDoyJ1v55F600J/XbmiUCDBbBDLdcpavPoH18kaNpikejflIUzZrg4Ytq3ao7O
         tT+lKVASrIVvCRE4e+f3OAcilUyWQUikpCVG5oeZ5Z8zfzK71Mfcl4oB1qHMd/AK3kkI
         OeGUWqWxFzTbokoI7EzPSS0BIxZURBxHDBrceu9TqxQ/qmzTRDLI5g3GVorYN0PGYQgy
         230YGI2QOmFKvBtOFLFpvsWxaXr4Vw0kL1YBAHQZYDeWumAecZpLQUi7AereTDY3Xj4X
         Vtsg==
X-Gm-Message-State: APjAAAXjHGBIwVFt8k3rAX3DzEdR8yIapPO87BmHgAXAvmbtzhzaXob2
        Yu1iK11oC4+EZx/aQyNVkIdxyvtXgJk=
X-Google-Smtp-Source: APXvYqwBNgRED6yRsaWlnJLa6J3Vw4BvD2nWSBTOSjouHQDAwr2BAFix1nNzBKQslqhWrzDRlDiVAg==
X-Received: by 2002:a65:4305:: with SMTP id j5mr11447953pgq.315.1581492226092;
        Tue, 11 Feb 2020 23:23:46 -0800 (PST)
Received: from workstation-portable ([103.211.17.79])
        by smtp.gmail.com with ESMTPSA id r26sm6398986pga.55.2020.02.11.23.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 23:23:45 -0800 (PST)
Date:   Wed, 12 Feb 2020 12:53:39 +0530
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
Subject: [PATCH 1/2 RESEND] scsi: fcoe: fcoe_ctlr: Pass lockdep expression to
 RCU lists
Message-ID: <20200212072339.GH14453@workstation-portable>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

lport->disc.rports and disc->rports are traversed using
list_for_each_entry_rcu outside an RCU read-side critical section but
under the protection of lport->disc.disc_mutex and disc->disc_mutex
respectively.

Hence, add corresponding lockdep expression to silence false-positive
lockdep warnings, and harden RCU lists.

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 drivers/scsi/fcoe/fcoe_ctlr.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 1791a393795d..0f59992c9cd9 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -2167,7 +2167,8 @@ static void fcoe_ctlr_disc_stop_locked(struct fc_lport *lport)
 	struct fc_rport_priv *rdata;
 
 	mutex_lock(&lport->disc.disc_mutex);
-	list_for_each_entry_rcu(rdata, &lport->disc.rports, peers) {
+	list_for_each_entry_rcu(rdata, &lport->disc.rports, peers,
+				lockdep_is_held(&lport->disc.disc_mutex)) {
 		if (kref_get_unless_zero(&rdata->kref)) {
 			fc_rport_logoff(rdata);
 			kref_put(&rdata->kref, fc_rport_destroy);
@@ -2703,7 +2704,8 @@ static unsigned long fcoe_ctlr_vn_age(struct fcoe_ctlr *fip)
 
 	next_time = jiffies + msecs_to_jiffies(FIP_VN_BEACON_INT * 10);
 	mutex_lock(&lport->disc.disc_mutex);
-	list_for_each_entry_rcu(rdata, &lport->disc.rports, peers) {
+	list_for_each_entry_rcu(rdata, &lport->disc.rports, peers,
+				lockdep_is_held(&lport->disc.disc_mutex)) {
 		if (!kref_get_unless_zero(&rdata->kref))
 			continue;
 		frport = fcoe_ctlr_rport(rdata);
@@ -3061,7 +3063,8 @@ static void fcoe_ctlr_vn_disc(struct fcoe_ctlr *fip)
 	mutex_lock(&disc->disc_mutex);
 	callback = disc->pending ? disc->disc_callback : NULL;
 	disc->pending = 0;
-	list_for_each_entry_rcu(rdata, &disc->rports, peers) {
+	list_for_each_entry_rcu(rdata, &disc->rports, peers,
+				lockdep_is_held(&disc->disc_mutex)) {
 		if (!kref_get_unless_zero(&rdata->kref))
 			continue;
 		frport = fcoe_ctlr_rport(rdata);
-- 
2.24.1

