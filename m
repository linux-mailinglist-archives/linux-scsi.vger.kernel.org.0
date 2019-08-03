Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36DEB807F0
	for <lists+linux-scsi@lfdr.de>; Sat,  3 Aug 2019 21:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfHCTA1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 3 Aug 2019 15:00:27 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36413 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728796AbfHCTA1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 3 Aug 2019 15:00:27 -0400
Received: (qmail 22420 invoked by uid 500); 3 Aug 2019 15:00:25 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Aug 2019 15:00:25 -0400
Date:   Sat, 3 Aug 2019 15:00:25 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Justin Piszcz <jpiszcz@lucidpixels.com>
cc:     'LKML' <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
Subject: Re: 5.2.x kernel: WD 8TB USB Drives: Unaligned partial completion
 (resid=78, sector_sz=512)
In-Reply-To: <006d01d549db$54e42140$feac63c0$@lucidpixels.com>
Message-ID: <Pine.LNX.4.44L0.1908031458330.22056-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, 3 Aug 2019, Justin Piszcz wrote:

> Attached 2 x brand new Western Digital 8TB USB 3.0 drives awhile back and
> ran some file copy tests and was getting these warnings-- is there any way
> to avoid these warnings?  I did confirm with parted that the partition was
> aligned but this appears to be something related to the firmware on the
> device according to [1] and [2]?
> 
> [1] https://patchwork.kernel.org/patch/9573203/
> [2] https://patchwork.kernel.org/patch/9597797/

Just out of curiosity, why did you not address your email to the author 
or committer of this patch?  Surely they would be the people in the 
best position to answer your questions.

Alan Stern

