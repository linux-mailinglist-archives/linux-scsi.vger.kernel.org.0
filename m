Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 303E525B41
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 02:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfEVAtX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 20:49:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46231 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfEVAtX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 20:49:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id o11so174090pgm.13
        for <linux-scsi@vger.kernel.org>; Tue, 21 May 2019 17:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1OgtekMFLFg97Gk2dH328ewvotz0xhZkFoa654FQFFQ=;
        b=h36ygJ+A1MpXiw/4MUvJ6vBxpbA1o2o/NblkFF+rxLlYh3nkCIITWpwgQG7a3ep6wA
         m197qNAMYgxrbqW9H3EWWI7GbzHkvoV9SN+r+sFpiQRtDdN/1iT/4fZvmx6GMHnDGYru
         v1BqJhXXw3qENwAdMbcdk4GgegelNhpYYGRFi73YKfDoKewebt4x+u0dplCLh47eqGur
         Fu9QuTuaKmXA1Cq0YEDUPbFLJoY5Ul3feE6F/M8XLtbbR3TUF0JzPuB1qyRLsK0ZRn9z
         7bV/f22lB3Ml/2y9N3EBhDEkbnG8RUaa3cnj+OB1g6N+fgvPNLw6ibYTcVheTYtnGIkl
         bGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1OgtekMFLFg97Gk2dH328ewvotz0xhZkFoa654FQFFQ=;
        b=SzE83/D9LU4eNQaQQhSNDFvPoIwg2dy2Uio8AYmZ2jucSihs04YLOHV0SyaSq0f1Ri
         u4fLuMYcp34nzTMDerKD74FWCW/AZ+74zFCefvTgQOQtXup6SSoEFXfRY/U19UV6t9c4
         Hc6qwFC8+zVEJyD7gBePT8Xg1tAyG7KMVPd0KOsVxya9L0PSYm/EauUsZBYH/PeE+oBQ
         Qz3fu1Jlq69dTSMGse7JkMUT85+5ISvcYOkKy2xJsg3Euu/OtxLmiWmDYX62cQ6ITRLE
         FHQ0HXR/g8vV7JFJ+VrogcVqgvOnBxhahNDs0wuV/26DdTJfOqgMgvWELoJOSRswreHE
         6l9Q==
X-Gm-Message-State: APjAAAWISbAjfWEIAXIpG9cpYaYahJs/6sjs6+qc2s2BntaDai1xPyY5
        9ztuD1P5fPx0YSZZL8Nbu3v8hcz5
X-Google-Smtp-Source: APXvYqzaR9XKv45O0W8bVFOLgezgiFN48z4BM7qMbEsADtOaS4RAtiZbIyM3V0QQ6csPVVgD/aB/oQ==
X-Received: by 2002:a63:754b:: with SMTP id f11mr86405687pgn.32.1558486162161;
        Tue, 21 May 2019 17:49:22 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j184sm22550121pge.83.2019.05.21.17.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 17:49:21 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>
Subject: [PATCH 00/21] lpfc: Update lpfc to revision 12.2.0.3
Date:   Tue, 21 May 2019 17:48:50 -0700
Message-Id: <20190522004911.573-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Update lpfc to revision 12.2.0.3

This patch set contains a bunch of fixes for lpfc.

The patches were cut against Martin's 5.3/scsi-queue tree


James Smart (21):
  lpfc: Fix alloc context on oas lun creations
  lpfc: Fix nvmet target abort cmd matching
  lpfc: Correct nvmet buffer free race condition
  lpfc: Revise message when stuck due to unresponsive adapter
  lpfc: Separate CQ processing for nvmet_fc upcalls
  lpfc: Fix nvmet handling of received ABTS for unmapped frames
  lpfc: Revert message logging on unsupported topology
  lpfc: Fix PT2PT PLOGI collison stopping discovery
  lpfc: Prevent 'use after free' memory overwrite in nvmet LS handling.
  lpfc: Cancel queued work for an IO when processing a received ABTS.
  lpfc: Fix hardlockup in scsi_cmd_iocb_cmpl
  lpfc: Rework misleading nvme not supported in firmware message
  lpfc: Fix memory leak in abnormal exit path from lpfc_eq_create.
  lpfc: Fix incorrect logical link speed on trunks when links down
  lpfc: Fix oops when driver is loaded with 1 interrupt vector
  lpfc: Fix poor use of hardware queues if fewer irq vectors
  lpfc: Fix fcp_rsp_len checking on lun reset
  lpfc: Fix FDMI fc4type for nvme support
  lpfc: Fix BFS crash with t10-dif enabled.
  lpfc: Fix kernel warnings related to smp_processor_id()
  lpfc: Update lpfc version to 12.2.0.3

 drivers/scsi/lpfc/lpfc_attr.c    |  34 ++-
 drivers/scsi/lpfc/lpfc_bsg.c     |   2 +-
 drivers/scsi/lpfc/lpfc_crtn.h    |   3 +-
 drivers/scsi/lpfc/lpfc_ct.c      |  14 +-
 drivers/scsi/lpfc/lpfc_els.c     |   1 +
 drivers/scsi/lpfc/lpfc_init.c    | 501 ++++++++++++++++++++++++++++++---------
 drivers/scsi/lpfc/lpfc_nvme.c    |  16 +-
 drivers/scsi/lpfc/lpfc_nvmet.c   | 330 +++++++++++++++++++++-----
 drivers/scsi/lpfc/lpfc_nvmet.h   |   1 +
 drivers/scsi/lpfc/lpfc_scsi.c    |  16 +-
 drivers/scsi/lpfc/lpfc_sli.c     |  72 +++---
 drivers/scsi/lpfc/lpfc_sli4.h    |  11 +-
 drivers/scsi/lpfc/lpfc_version.h |   2 +-
 13 files changed, 786 insertions(+), 217 deletions(-)

-- 
2.13.7

