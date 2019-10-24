Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 395B5E2729
	for <lists+linux-scsi@lfdr.de>; Thu, 24 Oct 2019 01:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392800AbfJWXvg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 23 Oct 2019 19:51:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33930 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389801AbfJWXvg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 23 Oct 2019 19:51:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B2B4D60FA9; Wed, 23 Oct 2019 23:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571874695;
        bh=RQzk63vXXXNk90usgWk/wx+IVC7KwqQNIfrdUilq1wg=;
        h=Date:From:To:Subject:From;
        b=Sebe89sfJjKrrsOpcmAaEqYI3PDqiWvMcyY7coEc46lE/XhSI9beT9UrgkD11F/2O
         olpeY8getbGV/VCx1tUz3gmOthzOdlre+La++LrpxP1G8h07RFPr6dL1YqTw9q6gGT
         /kJ9TlmfiYSmwQKNxvpOHMExBeJkKvaFmo4Z1Igc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6A1C160F5F
        for <linux-scsi@vger.kernel.org>; Wed, 23 Oct 2019 23:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571874695;
        bh=RQzk63vXXXNk90usgWk/wx+IVC7KwqQNIfrdUilq1wg=;
        h=Date:From:To:Subject:From;
        b=Sebe89sfJjKrrsOpcmAaEqYI3PDqiWvMcyY7coEc46lE/XhSI9beT9UrgkD11F/2O
         olpeY8getbGV/VCx1tUz3gmOthzOdlre+La++LrpxP1G8h07RFPr6dL1YqTw9q6gGT
         /kJ9TlmfiYSmwQKNxvpOHMExBeJkKvaFmo4Z1Igc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Oct 2019 16:51:35 -0700
From:   asutoshd@codeaurora.org
To:     linux-scsi@vger.kernel.org
Subject: Query: SCSI Device node creation when UFS is loaded as a module
Message-ID: <468eb805fa69da76c88a0a37aa209c7f@codeaurora.org>
X-Sender: asutoshd@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi
I'm loading the ufs-qcom driver as a module but am not seeing the 
/dev/sda* device nodes.
Looks like it's not being created.

I find the sda nodes in other paths being enumerated though:

/ # find /sys -name sda
/sys/kernel/debug/block/sda
/sys/class/block/sda
/sys/devices/platform/<...>/<xxx>.ufshc/host0/target0:0:0/0:0:0:0/block/sda
/sys/block/sda

All Luns are detected and I see sda is detected and prints for all the 
Luns as below -:
sd 0:0:0:0: [sda] .... ....-byte logical blocks:

... so on ...

But if I link it statically instead of a module, it works fine. All 
device nodes are created.

I'm trying to figure out where/how in SCSI does it create these device 
nodes - /dev/sd<a/b/c/d> ?
I've looked into sd.c but I couldn't figure out the exact place yet.

Any pointers please?

TIA

-asd
