Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1306211735C
	for <lists+linux-scsi@lfdr.de>; Mon,  9 Dec 2019 19:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfLISCa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 9 Dec 2019 13:02:30 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36741 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfLISCa (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 9 Dec 2019 13:02:30 -0500
Received: by mail-pl1-f193.google.com with SMTP id k20so6115067pls.3
        for <linux-scsi@vger.kernel.org>; Mon, 09 Dec 2019 10:02:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZKpPIltKLK7pg5BCBBI+dXrKqWOtlMc7mz0AbsY0vgw=;
        b=gJ0ys+qaC/ZQl4r4UaGkLdh+/ge9J5fdWyKLEY1uMbVUsSDINvDlCf3BA6tcAvNLHm
         PBmYs4fqGh8pWSDh2bbuA4tr1l09FbWtc4dPz4S3ucvsgDeem1aEIWNc4FnEfL9XHiH1
         lwgO8ttaYd7WMdU16Enj25pB31bcXv61UTTjjb72nBRkxM7GlXQiL3O1CVycdud+Dzdv
         EdRg9KnJCXRwNtVYCD+JS0ZmxwpqGjQQTjcuTF2y5hYx83YXE/EzE3HZGHaBBVqaLYVh
         eUGaE6X8TzE33Fz6/3rSnxAKr2UYGDhKRerOtbheO5P540TI95qGwJqEN1Yd9Y00BhLx
         i72Q==
X-Gm-Message-State: APjAAAUhSmcuURCfuk0ljZv7OJNgKsTCYAo6wEL2X4nKu7XjfLn/G98U
        dyi2gOCP+xb8EytAuwsr3+A=
X-Google-Smtp-Source: APXvYqzH1APr1NVL5oe27gZ6s915q5FilWWVREc2O+vBCnIF2VPSORP7tFtNKpZIM2pMAPxSqNyzQQ==
X-Received: by 2002:a17:90a:c790:: with SMTP id gn16mr320811pjb.76.1575914549960;
        Mon, 09 Dec 2019 10:02:29 -0800 (PST)
Received: from bvanassche-glaptop.roam.corp.google.com ([216.9.110.7])
        by smtp.gmail.com with ESMTPSA id f13sm132393pfa.57.2019.12.09.10.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 10:02:29 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/4] qla2xxx patches for kernel v5.6
Date:   Mon,  9 Dec 2019 10:02:19 -0800
Message-Id: <20191209180223.194959-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

Please consider these four small qla2xxx patches for kernel v5.6.

Thanks,

Bart.

Bart Van Assche (4):
  qla2xxx: Check locking assumptions at runtime in qla2x00_abort_srb()
  qla2xxx: Simplify the code for aborting SCSI commands
  qla2xxx: Fix point-to-point mode for qla25xx and older
  qla2xxx: Micro-optimize qla2x00_configure_local_loop()

 drivers/scsi/qla2xxx/qla_def.h  |  5 +----
 drivers/scsi/qla2xxx/qla_init.c |  9 ++++-----
 drivers/scsi/qla2xxx/qla_iocb.c | 14 ++++++++++----
 drivers/scsi/qla2xxx/qla_isr.c  |  5 -----
 drivers/scsi/qla2xxx/qla_os.c   | 17 ++++-------------
 5 files changed, 19 insertions(+), 31 deletions(-)

