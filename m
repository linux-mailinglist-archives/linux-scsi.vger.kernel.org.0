Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9421ADDB
	for <lists+linux-scsi@lfdr.de>; Sun, 12 May 2019 20:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfELS4A (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 12 May 2019 14:56:00 -0400
Received: from mail-vs1-f47.google.com ([209.85.217.47]:39447 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfELS4A (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 12 May 2019 14:56:00 -0400
Received: by mail-vs1-f47.google.com with SMTP id g127so6686106vsd.6
        for <linux-scsi@vger.kernel.org>; Sun, 12 May 2019 11:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=y/VOh/n6PwDadeGPafPF2dorJd+lcKfGZulH/3yVEdU=;
        b=ero3dxGlt0i98WKV5YFYVzLPIj7wkmH0GwHZSkNCZ91MlELYFo6qxQQDPy4JwJOd6R
         d1Kg8OJmGJfgFQ4VV7bfViUhoc32lGq5u0/XKzoYokU2U85O01JdO0InGFhzhpaoSei/
         gOcf4+E/gv0wYTDw9zd4nhiv7Kp26XVMC/l3rIithJQUEIlZsCLGETLuzhxr92CGfsid
         9zMO2WOaPYG6pYQB1SdaA5CosUzXSoBQX9PIy0032evJY9zwRg8c73Y9G3RwA1P/gK5P
         DGUqH5nzEMPDHCh9lxp6pepCUzRALow2RqXWJy5rmAUZ8ohJGZg6fXsLiHwsE2j679oU
         u8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=y/VOh/n6PwDadeGPafPF2dorJd+lcKfGZulH/3yVEdU=;
        b=euWhtGkhkRBRdlzlXLiDl7MGsE/KeRKITSvR/Y0rOJtPRbJUEaVcSaLM/zxhghxHtV
         417J/OOkrAUcJNmaU6RjoO9oy1SDXmBCtaAFdfIYVKk4Hrv311WET2c5Kw0O+7F5TO4Q
         akRSsnrJAWWKaWrTKFc9ALeBtjr9cJ/WIGheBEOYvBGD2VXTYKT9vt1fy6aUDsCOHb7o
         AARZ46cvNxWEFPtNc/deOuT3J4e4PtssL0bIbcYVf+khwKfLsPcGMKExOGq3lxtozm3I
         iYkSuBuz9WJnPS6iq4z4IK6sZKo77y4z6t1YyhHR/Zs6nGJv6T8ZgQtK3K77XCb7fNbk
         /vcw==
X-Gm-Message-State: APjAAAWHRHtETqrp90K5zjgEZ1bNF/u8D686KojDXP61+o/wFhUwUXZ+
        SOYjXqgHlTLtj60NAnSPFnf+5WtNmK9D5gdaHA==
X-Google-Smtp-Source: APXvYqx1vK8otyrYR8W9b6aGVoYQ4bJR0ZtbD+dmfArzSiowvS82h5IZ9v6qSi1Fm4RUeEFitrX/DBIAwkGTXievBiI=
X-Received: by 2002:a67:ea98:: with SMTP id f24mr3904252vso.128.1557687359274;
 Sun, 12 May 2019 11:55:59 -0700 (PDT)
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
From:   tedheadster <tedheadster@gmail.com>
Date:   Sun, 12 May 2019 14:55:48 -0400
Message-ID: <CAP8WD_be_3=iHDpMYL+fKEFW6BbG8s=0TUPVm4ojiS7orOr0zA@mail.gmail.com>
Subject: Poor SWIOTLB Performance with HIGHMEM64G
To:     Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Christoph,
  On the same hardware (reboot with different kernel) I am getting
_horrible_ disk I/O performance on the 5.1.1. kernel compiled on a
32-bit platform using HIGHMEM64G (PAE) to access 32GiB of physical
memory.

The numbers are truly terrible to copy a 16GiB file from one disk to a
different one:

highmem4g: 12 minutes
highmem64g: 88 minutes

A 733% slowdown seems really bad! Is this expected? If not, what can I
do to start to debug this?

This problem has existed for a long time (I have not bisected it), but
I only started to care about it now that I have to make this work in
production.

The kernel configuration changes are below.

- Matthew

--- config-5.1.1.highmem4g      2019-05-11 19:54:06.000000000 -0400
+++ config-5.1.1.highmem64g     2019-05-11 20:02:26.000000000 -0400

-CONFIG_PGTABLE_LEVELS=2
+CONFIG_PGTABLE_LEVELS=3

-CONFIG_HIGHMEM4G=y
-# CONFIG_HIGHMEM64G is not set
+# CONFIG_HIGHMEM4G is not set
+CONFIG_HIGHMEM64G=y
-# CONFIG_VMSPLIT_3G_OPT is not set
-# CONFIG_VMSPLIT_2G_OPT is not set
+CONFIG_X86_PAE=y

+# CONFIG_X86_PMEM_LEGACY is not set

+CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y

-# CONFIG_OLPC is not set

+CONFIG_HAVE_ARCH_HUGE_VMAP=y

+CONFIG_PHYS_ADDR_T_64BIT=y

+# CONFIG_LIBNVDIMM is not set

+# CONFIG_PAGE_TABLE_ISOLATION is not set

+CONFIG_NEED_DMA_MAP_STATE=y
+CONFIG_ARCH_DMA_ADDR_T_64BIT=y
+CONFIG_SWIOTLB=y
