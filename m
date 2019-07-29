Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8FB278815
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jul 2019 11:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfG2JNr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Jul 2019 05:13:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41492 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfG2JNq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 29 Jul 2019 05:13:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so17579591pgg.8;
        Mon, 29 Jul 2019 02:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FGIwEmsmTeBKX3uv2HVGT5VBixZ3R6wVRQMK4paWxpY=;
        b=lw+XYkhVr+PEZB+phyk0I6km3bOOaGbdtNO/kXkC12rrILqw+YRwECQZVi8/o/ch/d
         FwYRsi1Kvse+W+A4JRicaZyeia6dTsFLnXRMP0eAoAePV3RQUPmXo9sqPTSWGYwk3jiX
         vXNoWev4TtgmW2u/9Xfljd3zqVwBHPl991rZAuc+fempjV7OS86C723iUiLdw6Yni/VY
         Tw7koGZ6fzFCVgbaZTiYr+TtrWmy4JeQlUPVkqd0S2Y89pTNoHCXOfaiCjhCembiVM8x
         xd9s9Ejlw3OfsZ1kzYTCJnvRivlWItn16oEpuNA3S8SIF4TdlejwUsCdvyyOcKtyN/I6
         /NRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FGIwEmsmTeBKX3uv2HVGT5VBixZ3R6wVRQMK4paWxpY=;
        b=nakSdvdrLfX0h96OFOefH5YmBpKkjrk/0OtMcvoWxD3+yR2vrG7PEOR/42wckvs5hN
         8fqJQYj5S9Kin2dOxiEdwH9uWnM2Cto1lMqxxcgpq+NFq0FaD1DrbMP7KPLjsYFZq3KB
         ub0sOle/jILzC2k1zQgEuexRh/krZz2BFVrB37jytlLbG0RRltF8+8xY9jtoYsAlGOSJ
         TzMc9zWBHjYUfV0JpoHY/PYIeCJ9jjkrBEbNwxk5I0VMqSvfZu6Lipgc2rNT74466II6
         Tcx9yR44Rothp5vu5POmEqlDh49SpDepWAezCMAJFFu/CswThwTS8pxFb85UhYUWVSZs
         IeTw==
X-Gm-Message-State: APjAAAVivEHOWiBYLoD25kpLKcgfdmaPnCPvgxXV3K9cmltwyjYie9im
        mY81lQScTN+Xi2tB2eVhZ1/lEuVxkhI=
X-Google-Smtp-Source: APXvYqxAfAb1vND3S11uFh91InBJQZ/lXjcy2xGtpgE+ZVcN6esyoWcuH92OZSd+pEPH3Hi1n+B0JA==
X-Received: by 2002:a63:494d:: with SMTP id y13mr105020405pgk.109.1564391626074;
        Mon, 29 Jul 2019 02:13:46 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id g2sm64643446pfi.26.2019.07.29.02.13.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 02:13:45 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     lduncan@suse.com, cleech@redhat.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] scsi: libiscsi: Fix possible null-pointer dereferences in iscsi_conn_get_addr_param()
Date:   Mon, 29 Jul 2019 17:13:39 +0800
Message-Id: <20190729091339.30815-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In iscsi_conn_get_addr_param(), sin6 may be NULL when reaching lines
3479 and 3487:
    len = sprintf(buf, "%pI6\n", &sin6->sin6_addr);
    len = sprintf(buf, "%hu\n", be16_to_cpu(sin6->sin6_port));

Thus, possible null-pointer dereferences may occur.

To fix these bugs, sin6 is checked before being used, and len is
initialized to -EINVAL.

These bugs are found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/scsi/libiscsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index ebd47c0cf9e9..58f072d5c43f 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -3457,7 +3457,7 @@ int iscsi_conn_get_addr_param(struct sockaddr_storage *addr,
 {
 	struct sockaddr_in6 *sin6 = NULL;
 	struct sockaddr_in *sin = NULL;
-	int len;
+	int len = -EINVAL;
 
 	switch (addr->ss_family) {
 	case AF_INET:
@@ -3475,14 +3475,14 @@ int iscsi_conn_get_addr_param(struct sockaddr_storage *addr,
 	case ISCSI_HOST_PARAM_IPADDRESS:
 		if (sin)
 			len = sprintf(buf, "%pI4\n", &sin->sin_addr.s_addr);
-		else
+		else if (sin6)
 			len = sprintf(buf, "%pI6\n", &sin6->sin6_addr);
 		break;
 	case ISCSI_PARAM_CONN_PORT:
 	case ISCSI_PARAM_LOCAL_PORT:
 		if (sin)
 			len = sprintf(buf, "%hu\n", be16_to_cpu(sin->sin_port));
-		else
+		else if (sin6)
 			len = sprintf(buf, "%hu\n",
 				      be16_to_cpu(sin6->sin6_port));
 		break;
-- 
2.17.0

