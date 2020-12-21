Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121A02DFE00
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Dec 2020 17:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgLUQZK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Dec 2020 11:25:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22179 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725811AbgLUQZK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 21 Dec 2020 11:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608567824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uiRubI3oETCvVOh+zg0XhoDMdq17a8X4QGnnA5oDaZk=;
        b=T5S9282iw6tqzDFjQw55dGbVg8UIJTZj5hGJq9eqaqJgZ+qhwB5Sf+9l9TKrbtKnSyWrOd
        fvjUtw+2xiZBvngvVjpJcrRnn+c/6PYdolIrO4oXSzywRCKFshrKG+ltPQRsN86HUwqKlA
        GRupgqPfD9KHEv9tSC9nPkPcO8nY23k=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-9p9c-L3CPKaj-TynCdxtYg-1; Mon, 21 Dec 2020 11:23:41 -0500
X-MC-Unique: 9p9c-L3CPKaj-TynCdxtYg-1
Received: by mail-oo1-f69.google.com with SMTP id l191so4031658ooc.15
        for <linux-scsi@vger.kernel.org>; Mon, 21 Dec 2020 08:23:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uiRubI3oETCvVOh+zg0XhoDMdq17a8X4QGnnA5oDaZk=;
        b=SJjRyWevnY1wQBHVEyrNuGfDVLkSu4NfIOwwRAFjnYqpWWCLEH+kYedDqALO7Oho7y
         kUowdo7AbNJN2Vj0Bu9c21P8rE46uT9qtDuDnIZsALiPQ9TVUkci9OqKQn4rsNCAnSVP
         EoYrBdBvN1Y7yqv0xzqO6QXnFavIOq6fQLk1D0uaiQUggGGeqpt7EV85ljZ11LexXYxI
         +YDgxu/JNUSUTlKF9Toi5LCkiavyRJFnBsfSp2Wh+7WasEoIH0BFde2Gy6ISrA9Ufiwd
         VPApRa3wDp6NHfzSq4M/HKKFJ3dJfPkxXEjQ/tTuJ2/8919dtB9om+0ZJEdQP1LH5II8
         XoaA==
X-Gm-Message-State: AOAM530dl/h0hvmET83B9HZheDworMjEdqlSugOxywjm8+skgqC3UUpd
        n/QxQ9iJ5jrEHAUPAq3PNnMLp7YlDK8A7DDIbGIxn61Kvkh4nt08scpj7h86MSrIRJ+mVUTa7XO
        pHCtuaT9WIr654B48S7YI8A==
X-Received: by 2002:a05:6830:1482:: with SMTP id s2mr12898941otq.296.1608567820970;
        Mon, 21 Dec 2020 08:23:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwj7yy05ARrHiu7d6hk216DQqhec4uZlxDRe8wh6EiwRslymmkvnn13c/nidGQr11Cuecka6g==
X-Received: by 2002:a05:6830:1482:: with SMTP id s2mr12898916otq.296.1608567820808;
        Mon, 21 Dec 2020 08:23:40 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r13sm3977307oti.49.2020.12.21.08.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 08:23:40 -0800 (PST)
From:   trix@redhat.com
To:     njavali@marvell.com, mrangankar@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] scsi: qedi: add printf attribute to log function
Date:   Mon, 21 Dec 2020 08:23:35 -0800
Message-Id: <20201221162335.3756353-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Attributing the function allows the compiler to more thoroughly
check the use of the function with -Wformat and similar flags.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/scsi/qedi/qedi_dbg.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qedi/qedi_dbg.h b/drivers/scsi/qedi/qedi_dbg.h
index 37d084086fd4..b2c9b0a2db6a 100644
--- a/drivers/scsi/qedi/qedi_dbg.h
+++ b/drivers/scsi/qedi/qedi_dbg.h
@@ -78,13 +78,16 @@ struct qedi_dbg_ctx {
 #define QEDI_INFO(pdev, level, fmt, ...)	\
 		qedi_dbg_info(pdev, __func__, __LINE__, level, fmt,	\
 			      ## __VA_ARGS__)
-
+__printf(4, 5)
 void qedi_dbg_err(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
 		  const char *fmt, ...);
+__printf(4, 5)
 void qedi_dbg_warn(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
 		   const char *fmt, ...);
+__printf(4, 5)
 void qedi_dbg_notice(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
 		     const char *fmt, ...);
+__printf(5, 6)
 void qedi_dbg_info(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
 		   u32 info, const char *fmt, ...);
 
-- 
2.27.0

