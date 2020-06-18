Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B681FF28F
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jun 2020 15:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbgFRNDP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 18 Jun 2020 09:03:15 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.65]:35655 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730041AbgFRNDO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 18 Jun 2020 09:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1592485392; i=@ts.fujitsu.com;
        bh=oYumhRJxkWCfO0i7c/hvuANQHDicGRWYDiS67PXa1VI=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=nI7WjRcm43mniDoOGabfjJWNrFkSNxKMEbJcN5pKG9Nq8CQho8LAZITVTGqRkVWRW
         CRZnji6Pj2a7E6mFP03nDZSEqZa8ZtafpFhxblRtdEKm/Dr6OJ1cbxYmmstdHQlqf0
         QC6bp8hJOZ57Ug236d3/c+MRyDPH9vh8LApM0Oi9vG4Z7YDQRUOrVFoPdnnDj54dvT
         yPzK8qRZo7d9nJy5H9kakpKPDsC0vyVhuq1ZtDlQqq9hHx6J3bCaGNWqg5U8tf9I39
         dtW3HxQMlLg92q/YnQcU4pb5OCLRByWfCmnEI1Jqd9j+840FSHTgD+badOzkeOctdK
         vNVpcoacaXd7g==
Received: from [100.112.196.81] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-west-1.aws.symcld.net id 2F/50-63843-F066BEE5; Thu, 18 Jun 2020 13:03:11 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeJIrShJLcpLzFFi42Kxs+EI1eVPex1
  nsGyLosXhhW+YLLqv72CzmNEWZrH8+D8mi7+TbrBatC59y+TA5rFz1l12j8c9Z9g8Pj69xeLx
  eZNcAEsUa2ZeUn5FAmvGiqszmQoeslbs2HaDrYHxOUsXIyeHkMBkRok751kh7OmMEtNuJYPYb
  AIGEism3Qeq4eIQEVjDKLHyzjxmkASzQKXE7a3TwWxhAU6JTd3n2UFsFgFViYPHt4AN5RWwk/
  j4YBrYUAkBeYmOA5NZJjByLmBkWMVokVSUmZ5RkpuYmaNraGCga2hopGtoaaFraGGml1ilm6S
  XWqpbnlpcomuol1herFdcmZuck6KXl1qyiREYGikFx3btYHz7+oPeIUZJDiYlUd7wxNdxQnxJ
  +SmVGYnFGfFFpTmpxYcYZTg4lCR4XyYD5QSLUtNTK9Iyc4BhCpOW4OBREuHlSwFK8xYXJOYWZ
  6ZDpE4xWnKcPjpvETPHi6uLgeSqA9NXMQux5OXnpUqJ8+aDzBMAacgozYMbB4ulS4yyUsK8jA
  wMDEI8BalFuZklqPKvGMU5GJWEeeeATOHJzCuB2/oK6CAmoIO0wl+BHFSSiJCSamB6pHg8wiR
  LOOB3bHXhr+pPTFMbuLIMf1nOfZax2OiQGV/JRZeJh+O1DacHVyoe1Z68vTb/EfM9/2cZMto3
  ajQKVpzxeXPBx/Te1/tFtzoNPGtVjx6t19r+6MjW0L27QmNOnQrewbHBwu8mQ7v+Hh+nhAUOU
  7wY3fUcjpfFlVTP31XKdC0pYO6DWJO7QXqWM30VnFMZ3oX5xoYWSzWeyQ8p/LMxdxMfz58LL3
  bd9709d+m89dvmHQw+WL2dP4AtIfuezaeLs21+/7s/jzk29cBze/6jMXGVb2XnKTbtyDQyub+
  8/32vdG+7nePtg1Hqv1gL625NYvrsyrHvxp8zN5lTjgv8015iZTbz0SmFj1ZKLMUZiYZazEXF
  iQCp080+IAMAAA==
X-Env-Sender: bstroesser@ts.fujitsu.com
X-Msg-Ref: server-59.tower-291.messagelabs.com!1592485390!424327!1
X-Originating-IP: [62.60.8.85]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25008 invoked from network); 18 Jun 2020 13:03:11 -0000
Received: from unknown (HELO mailhost4.uk.fujitsu.com) (62.60.8.85)
  by server-59.tower-291.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 18 Jun 2020 13:03:11 -0000
Received: from x-serv01 ([172.17.38.52])
        by mailhost4.uk.fujitsu.com (8.14.5/8.14.5) with SMTP id 05ID34SY017661;
        Thu, 18 Jun 2020 14:03:04 +0100
Received: from VTC.emeia.fujitsu.local (unknown [172.17.38.7])
        by x-serv01 (Postfix) with ESMTP id 2F72120300;
        Thu, 18 Jun 2020 15:03:04 +0200 (CEST)
From:   Bodo Stroesser <bstroesser@ts.fujitsu.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Cc:     JiangYu <lnsyyj@hotmail.com>, Daniel Meyerholt <dxm523@gmail.com>,
        Bodo Stroesser <bstroesser@ts.fujitsu.com>
Subject: 
Date:   Thu, 18 Jun 2020 15:02:58 +0200
Message-Id: <20200618130300.31094-1-bstroesser@ts.fujitsu.com>
X-Mailer: git-send-email 2.12.3
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This small series of patches consists of:
   [PATCH 1/2] scsi: target: tcmu: Optimize use of flush_dcache_page
   [PATCH 2/2] scsi: target: tcmu: Fix crash in tcmu_flush_dcache_range

Together with commit
   8c4e0f212398 scsi: target: tcmu: Fix size in calls to tcmu_flush_dcache_range
these patches fix crashes in tcmu on ARM.

The first patch of this series already was sent some weeks ago
as "PATCH RFC", since it was untested at that time.

Meanwhile I added patch 2 of the series to fix the crash reported in:
   https://github.com/open-iscsi/tcmu-runner/issues/627
   https://bugzilla.kernel.org/show_bug.cgi?id=208045

All three patches together were tested on ARM with kernel
4.19.118 and 5.7.2 (see github issue and bugzilla).

