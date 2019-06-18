Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BACDC49D51
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 11:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbfFRJc1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 05:32:27 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:45760 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbfFRJcY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jun 2019 05:32:24 -0400
Received: by mail-pf1-f175.google.com with SMTP id r1so7313418pfq.12
        for <linux-scsi@vger.kernel.org>; Tue, 18 Jun 2019 02:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gWhYtG+O92GZV8JZ8NnFfgWfWCGq9CTg7OmXXwxalvE=;
        b=gHwtnROI7gR7KVVToLi7lF3xQpEDURwkYjRKtYCdzkSSxncdEGjQqKRpJJdWiWnU6J
         6jbWM/Fo2bupZlFW6nYgtw4dip068Fwrnusw4x/nLBt9EB5VwzbD5l3/wUfLgfiLgKL9
         LBmTei0oLLExSm5n4IlHzSzx+Fy7djWotY+ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gWhYtG+O92GZV8JZ8NnFfgWfWCGq9CTg7OmXXwxalvE=;
        b=QnEcdtqddLHA/GqXavbfXlUCakrfVRikqkkdyX6AH6gyYiNvIaDOK6lsAerTd2l9JE
         C0CTF2JqOuTC0iB6jWlC3DVI81xhFWSj6NKoaB4jazgReW9ErEaecctZ6SMnIMDmyUYY
         VHJJtL7Y/CdmGN0O3WLj8hKa+HuC44HDL5jlNDaHO3NSq9zU2PJ96V+Zy5mvHIB6oQoW
         Z3Q2lrpGqH5FT8m6TK2wBdu9L5ZdLgdPcC/5ozA9SDz5+HorDfFghI6UlFYCa9iUIeb7
         2kqvQKmmjZIDVi+ldKsXCsQcHURR6GclK2OV8d0A1LVbhSn9qPTqoyWQnEXLUU78EN/t
         bqgA==
X-Gm-Message-State: APjAAAVSdTh/2FsxW4hrO2AgdjoWA5KzIQWp7WPJDrShY+VdZKRooJRm
        Gn2i+cZYRWLlCMLJ+VT4Qh5wnhAkVjI/IHqTe+UOHFGlIaA6810oqPzwMNC3zluM41cU7mPJnCb
        NNqAfyVGD9kcl+VIcGgLF8TRQHvJMPNdg1PxDBhs9aD1AfCVJCZK2XSvWZzliRC2lH+Xx7V3WGl
        p2WuYu9IPQmA==
X-Google-Smtp-Source: APXvYqxGib3RAGofZTouDd0w0YwGY3HVYuMpMKEg7VczYyfC5LaDTpMOUSTDssn/1eQmTXZV5P07mQ==
X-Received: by 2002:a17:90a:a407:: with SMTP id y7mr4044626pjp.97.1560850343171;
        Tue, 18 Jun 2019 02:32:23 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z20sm21394809pfk.72.2019.06.18.02.32.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 02:32:22 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH 00/18] megaraid_sas: driver updates to 07.710.06.00-rc1
Date:   Tue, 18 Jun 2019 15:01:49 +0530
Message-Id: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patchset contains performance improvements in megaraid_sas driver
for latest MegaRAID Aero family of adapters along with few driver fixes.

Chandrakanth Patil (18):
  megaraid_sas: Add 32 bit atomic descriptor support to AERO adapters
  megaraid_sas: Add support for Non-secure Aero PCI IDs
  megaraid_sas: Remove few debug counters from IO path
  megaraid_sas: Call disable_irq from process IRQ poll
  megaraid_sas: Release Mutex lock before OCR in case of DCMD timeout
  megaraid_sas: In probe context, retry IOC INIT once if firmware is in
    fault
  megaraid_sas: Don't send FPIO to RL Bypass queue
  megaraid_sas: Handle sequence JBOD map failure at driver level
  megaraid_sas: megaraid_sas: Add check for count returned by
    HOST_DEVICE_LIST DCMD
  megaraid_sas: RAID1 PCI bandwidth limit algorithm is applicable for
    only Ventura
  megaraid_sas: Offload Aero RAID5/6 division calculations to driver
  megaraid_sas: Add support for MPI toolbox commands
  megaraid_sas: Add support for High IOPs queues
  megaraid_sas: Enable coalescing for high IOPs queues
  megaraid_sas: Set affinity for high IOPs reply queues
  megaraid_sas: Use high IOPs queues based on IO workload
  megaraid_sas: Introduce various Aero performance modes
  megaraid_sas: Update driver version to 07.710.06.00-rc1

 drivers/scsi/megaraid/megaraid_sas.h        |  78 ++++++-
 drivers/scsi/megaraid/megaraid_sas_base.c   | 301 +++++++++++++++++++++++++---
 drivers/scsi/megaraid/megaraid_sas_fp.c     |  79 ++++++++
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 248 ++++++++++++++++-------
 drivers/scsi/megaraid/megaraid_sas_fusion.h |  25 ++-
 5 files changed, 623 insertions(+), 108 deletions(-)

-- 
2.9.5

