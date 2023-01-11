Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D01F666798
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Jan 2023 01:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjALAZT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Wed, 11 Jan 2023 19:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjALAZS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 11 Jan 2023 19:25:18 -0500
X-Greylist: delayed 549 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 Jan 2023 16:25:07 PST
Received: from bufferz9.csloxinfo.com (bufferz.csloxinfo.com [203.146.237.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E83AA2F799
        for <linux-scsi@vger.kernel.org>; Wed, 11 Jan 2023 16:25:07 -0800 (PST)
Received: from mailx2-13.cslox.com (unknown [10.20.140.33])
        by bufferz9.csloxinfo.com (Postfix) with ESMTP id 050DE23D9D45;
        Thu, 12 Jan 2023 07:15:56 +0700 (ICT)
IronPort-SDR: 63bf513b_CbW5yv/IebrWIngXWZUwP4NUFE9xkb2FB10mCzRmzXV76Sy
 KmU8xvtgEr0dip3PSDYFogOsUFU5JYc0HUBQLEQ==
X-IPAS-Result: =?us-ascii?q?A0D7/wCyUL9j/36S/htagRKFexIYAZEjgmuFI40PgUBdA?=
 =?us-ascii?q?QF3CwiDCwtQgUCDdFYfgV4PAQEBAQEBAQEBHTAEAQGBUgGDKAUDhRoBJUsBB?=
 =?us-ascii?q?gEBAQEDAgMBAQEBAQEDAgUDAgEBBgSBChOFdYZPTDMwFDACORcTNIVtAgWtN?=
 =?us-ascii?q?m6BNBoCZYRdmj9OAYFUiW+DL4VqFgaCDYQIgkiHAYIumi+BPXyBJw6BSUgEG?=
 =?us-ascii?q?jcDMxEdNwkDC20KQDUIDksrGhsHgQoqJAQVAwQEAwIGEwMgAg0oMRQEKQcMD?=
 =?us-ascii?q?ScmawkCAyFmAwMEKC0JQAcmJDwHVjwDAg8fNwYDCQMCH06BIA0XBQMLFSpHB?=
 =?us-ascii?q?Ag2BQZSEgIIDxIPCSNDDkI3NhMGMFcLDhMDUB5/MgSCFlecUoMlgWeBSZMoj?=
 =?us-ascii?q?Q2hOSMHA4Nvl1eIcxoygR6CW4xchi8IFgOECo14hg+GGosfokeEUYIwUA6BW?=
 =?us-ascii?q?YEFgVkUGk8BAYEZAxmFWpcmQIEICYwjAQE?=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:cXa52KODFzuOIsBcTu2jsMiBIKoaSvp037BN7TEUdfU1SL38qy
 nKpp4mPHDP+VUssR0b+OxoW5PvfZqjz+8T3WB5B97LN2WIhILCFvAB0WKN+V3dMhy71spm7+
 NMUYhbTPXtEFl3itv76gGkE9AmhOKK6rysmI7lokuFmjsaDZ1d0w==
X-IronPort-Anti-Spam-Filtered: true
Spam_Positive: LL
X-IronPort-AV: E=Sophos;i="5.96,318,1665421200"; 
   d="scan'208";a="453445677"
Received: from unknown (HELO mail.osstem.co.th) ([27.254.146.126])
  by mail-2.csloxinfo.com with ESMTP; 12 Jan 2023 07:15:55 +0700
Received: from localhost (localhost [127.0.0.1])
        by mail.osstem.co.th (Postfix) with ESMTP id 407585A883B;
        Wed, 11 Jan 2023 21:10:35 +0700 (+07)
Received: from mail.osstem.co.th ([127.0.0.1])
        by localhost (mail.osstem.co.th [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id AR_288AV5wIB; Wed, 11 Jan 2023 21:10:34 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by mail.osstem.co.th (Postfix) with ESMTP id 7D24B5A8827;
        Wed, 11 Jan 2023 21:10:32 +0700 (+07)
X-Virus-Scanned: amavisd-new at mail.osstem.co.th
Received: from mail.osstem.co.th ([127.0.0.1])
        by localhost (mail.osstem.co.th [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8kEbnSlK4_Nn; Wed, 11 Jan 2023 21:10:32 +0700 (+07)
Received: from [192.168.10.100] (unknown [79.110.55.3])
        by mail.osstem.co.th (Postfix) with ESMTPSA id 51E985A879E;
        Wed, 11 Jan 2023 21:10:11 +0700 (+07)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: Information
To:     Recipients <account@osstem.co.th>
From:   "Mrs. Reem E. Al-Hashimi" <account@osstem.co.th>
Date:   Wed, 11 Jan 2023 15:09:51 +0100
Reply-To: nationalbureau@kakao.com
Message-Id: <20230111141012.51E985A879E@mail.osstem.co.th>
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_MR_MRS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hello Sir/Ma,

My name is Mrs. Reem E. Al-Hashimi, The Emirates Minister of State  United Arab Emirates.I have a great business proposal to discuss with you, if you are interested in Foreign Investment/Partnership please reply with your line of interest.


PLEASE REPLY ME : rrrhashimi2022@kakao.com

Reem
