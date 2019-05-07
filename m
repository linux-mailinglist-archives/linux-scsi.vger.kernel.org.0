Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB9E0156EB
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 02:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfEGA1g (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 6 May 2019 20:27:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35075 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfEGA1g (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 6 May 2019 20:27:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id h1so7312631pgs.2
        for <linux-scsi@vger.kernel.org>; Mon, 06 May 2019 17:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Aqwi13k1gojDp35uBRuknUsbcvo62Bj8CUXw3XYWxFk=;
        b=bvFdrt0D56Ktqb/TM5HI3oPUp2E7PFc2+0fxsscUsTKyXFEASmP8WwQZCw6o6BAfqf
         YirP15UapHJc4D1Kk9kCkL3+eXYvmFddykdpyBwL9zTlALsMmyaFmBq6UneZuuH86pAk
         +GGElzcfeyuxxdf8MmntFjQl1jv9zrazQxV8TnPS44jwcjW0JIvpGt6rhmbB4HF1eX/3
         T+92Neafy5h6Tk7SM2aXwe2MKudDBfqcveDSxUV7GL0NleEDrBavy6l3xpVi1ZBVhqL3
         jt7AchLm2M3tYtaXZvosydF8+4V3FrNH+cN0wMGkKbH8WkNP2/ZvRg6ccb7T3i95s1l9
         BTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Aqwi13k1gojDp35uBRuknUsbcvo62Bj8CUXw3XYWxFk=;
        b=K0YPycoHw+PxYUsOlN62UMWdtJgmeBe+iQU1p+vXLFeEQH2zBUd9zHNN8FPUz7hQJ1
         JgVjaWxdkamhIu9vduvz0cg5R6i51Zu2FO30r2n+UbBnq/+KPTK3EzBHW9Mvvtblix7X
         LUlsIZpchORWONM9l2gpd5H/XQ48/FC1sUSnefcnALwZyX9xfUlmpK0nNM1tUfsgp7D7
         SnyY4mYM+n1AAxeyzAGxn83GjdGivKWxp2m30ZBGAgLjrfcFJvuj2dxatjFskJXFaEc1
         SwCyeTNDhFqEFoVr2+gy55ORMv7h9Q0NX7kEXU9/LpT2G3JWsUOyLoTOOLqLiwLysJVD
         t1Fg==
X-Gm-Message-State: APjAAAX16hCl7hzX0lnOaMlubA+9ufseYIwSAEhNqCDdDkbcxuvMF5ji
        QEYoLN9bSK5OtnV7cp6bUutkFCwk
X-Google-Smtp-Source: APXvYqxVRJcUaQ0NqdLS4z7CkEx/FJdBz8uFQIb6G7ug3WhKBiRwYrOsoRcoqzHzQ+tZSM/bipRakQ==
X-Received: by 2002:aa7:99c7:: with SMTP id v7mr37832632pfi.103.1557188855333;
        Mon, 06 May 2019 17:27:35 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id r8sm14756623pfn.11.2019.05.06.17.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 17:27:34 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>
Subject: [PATCH v2 0/4] lpfc updated for 12.2.0.2
Date:   Mon,  6 May 2019 17:26:46 -0700
Message-Id: <20190507002650.23210-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Update lpfc to revision 12.2.0.2

A quick patch set that resolves lockdep checking issues and
addresses a couple of bugs found when inspecting the paths
for the lockdeps.

The patches were cut against Martin's 5.2/scsi-queue tree

v2:
  update patch 1 with fix for around lpfc_sli_iocbq_lookup()

James Smart (4):
  lpfc: resolve lockdep warnings
  lpfc: correct rcu unlock issue in lpfc_nvme_info_show
  lpfc: add check for loss of ndlp when sending RRQ
  lpfc: Update lpfc version to 12.2.0.2

 drivers/scsi/lpfc/lpfc_attr.c    | 37 +++++++++++-------
 drivers/scsi/lpfc/lpfc_els.c     |  5 ++-
 drivers/scsi/lpfc/lpfc_sli.c     | 84 +++++++++++++++++++++++++---------------
 drivers/scsi/lpfc/lpfc_version.h |  2 +-
 4 files changed, 80 insertions(+), 48 deletions(-)

-- 
2.13.7

