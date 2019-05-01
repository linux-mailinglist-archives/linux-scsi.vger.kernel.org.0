Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE8EC10C82
	for <lists+linux-scsi@lfdr.de>; Wed,  1 May 2019 19:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfEAR7k (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 1 May 2019 13:59:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45637 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfEAR7j (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 1 May 2019 13:59:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id o5so8487872pls.12
        for <linux-scsi@vger.kernel.org>; Wed, 01 May 2019 10:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OJeUrYuVQqKoglVvcE7k+He6ncO55aj4gaMDVceaXdM=;
        b=srPwei2KszJOGKGjZW3/VYCK4nx+R4oki+J2Ub7S8/qkCQt1CxeB2hzTHbBjQYAM5k
         vWpHfVCBTH1kWD/KmkjaoLdUOT29ic3eYLPP1NR0YkCGnrQNhMbrNBYjRc5VG+gHs2yz
         TSu1j3fwopChUb322YdblC71wxdRMTV64RaFKueo1vjjiPAOx0hcIHLVcvM7ZpcFRvpi
         Xykm5rawIgrqxKCc2xHDg1luuSdCGVFL16wOiMu3erOqjW6/sgyGdi1DVzCUoRZ/wzPu
         xc9h8U7I2e/P+QPVkARwYkYvwPPSQvwNTmTB0H0fqUfGoSWajJaD+phfD2D4PTCWrZP+
         UCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OJeUrYuVQqKoglVvcE7k+He6ncO55aj4gaMDVceaXdM=;
        b=ItExTo+kAbhcnr9GaNoj5YSOEX0VpBoq72cP3tT3xLRprNNXAYAEnGP3imB7G2VLMV
         fvln+VOhoYQRLj6OPRTRc9D4NfprzcP3+2AiTTsczsee7LDtqTc5HqrEzIy5i5BMqBud
         TYudXamd8CRWcSwmNaHi8b7rTP4ZqU3YO3Uhp5KwoFq503epoM3Z81cuZFGeb2PSfIwl
         ZZAx88x1Bij1VqeDmuUhM67RGEg+y2GFZ+NJf19QH66p1P4JnH0A+5VkVFIKkjNQr/pG
         wLTAnrdXcT2GyO+lgZX2EuEPOR6LTozUGQGlaaBbOYplkOdtYiDEdyBI5zXa4gmbv64a
         yEqw==
X-Gm-Message-State: APjAAAUNU2/BxkC84eOPy5N9OLYjScBO0xEv9asiCpUAPsLvhML26Mux
        TnQ/gZ5RmgMybpbmjyIqwBgXuj3d
X-Google-Smtp-Source: APXvYqzH055jCPNN+iC2pNu0cCGyKeufZBjKYY75Fz3eX5hjFcKKFGYwn2T4ivz+fU3dML85JWk0rg==
X-Received: by 2002:a17:902:e407:: with SMTP id ci7mr33749632plb.219.1556733579092;
        Wed, 01 May 2019 10:59:39 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z7sm72906679pgh.81.2019.05.01.10.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 May 2019 10:59:38 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>
Subject: [PATCH 0/4] lpfc updated for 12.2.0.2
Date:   Wed,  1 May 2019 10:59:22 -0700
Message-Id: <20190501175926.4551-1-jsmart2021@gmail.com>
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


James Smart (4):
  lpfc: resolve lockdep warnings
  lpfc: correct rcu unlock issue in lpfc_nvme_info_show
  lpfc: add check for loss of ndlp when sending RRQ
  lpfc: Update lpfc version to 12.2.0.2

 drivers/scsi/lpfc/lpfc_attr.c    | 37 ++++++++++++++++++-------------
 drivers/scsi/lpfc/lpfc_els.c     |  5 ++++-
 drivers/scsi/lpfc/lpfc_sli.c     | 48 ++++++++++++++++++++++++++--------------
 drivers/scsi/lpfc/lpfc_version.h |  2 +-
 4 files changed, 58 insertions(+), 34 deletions(-)

-- 
2.13.7

