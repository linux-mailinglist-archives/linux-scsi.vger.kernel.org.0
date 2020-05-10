Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E731CCCF1
	for <lists+linux-scsi@lfdr.de>; Sun, 10 May 2020 20:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgEJSc5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 10 May 2020 14:32:57 -0400
Received: from smtp.infotech.no ([82.134.31.41]:54913 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbgEJSc5 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 10 May 2020 14:32:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id CD7DF20423B
        for <linux-scsi@vger.kernel.org>; Sun, 10 May 2020 20:32:54 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zmTAaIx2yt9K for <linux-scsi@vger.kernel.org>;
        Sun, 10 May 2020 20:32:48 +0200 (CEST)
Received: from [192.168.48.23] (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id 9601C204165
        for <linux-scsi@vger.kernel.org>; Sun, 10 May 2020 20:32:48 +0200 (CEST)
Reply-To: dgilbert@interlog.com
To:     SCSI development list <linux-scsi@vger.kernel.org>
From:   Douglas Gilbert <dgilbert@interlog.com>
Subject: scsi_alloc_target: parent of the target (need not be a scsi host)
Message-ID: <59d462c4-ceab-041a-bbb5-5b509f13a123@interlog.com>
Date:   Sun, 10 May 2020 14:32:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This gem is in scsi_scan.c in the documentation of that function's first
argument.
"need not be a scsi host" should read "it damn well better be a scsi host"
otherwise that function will crash and burn!

I'm trying to work out why the function: starget_for_each_device() in scsi.c
does _not_ use that collection right in front of it (i.e.
scsi_target::devices). Instead, it step up to the host level, and iterates
over all devices (LUs) on that host and only calls the given function for
those devices that match the channel and target numbers. That is bizarrely
wasteful if scsi_target::devices could be iterated over instead.

Anyone know why this is?

Doug Gilbert
