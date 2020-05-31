Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D968A1E9A8B
	for <lists+linux-scsi@lfdr.de>; Sun, 31 May 2020 23:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgEaVax (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 31 May 2020 17:30:53 -0400
Received: from smtp.infotech.no ([82.134.31.41]:38926 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbgEaVax (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 31 May 2020 17:30:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id ECF4920419E;
        Sun, 31 May 2020 23:30:50 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QIPtT9XRmp30; Sun, 31 May 2020 23:30:49 +0200 (CEST)
Received: from [192.168.48.23] (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id 4970120414B;
        Sun, 31 May 2020 23:30:47 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH] scsi_debug: implement 'sdebug_lun_format' and update
 max_lun
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
References: <20200529133942.146413-1-hare@suse.de>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <06cfcfc8-3f1b-b6f0-56fc-d517756912a3@interlog.com>
Date:   Sun, 31 May 2020 17:30:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529133942.146413-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-05-29 9:39 a.m., Hannes Reinecke wrote:
> Implement 'flat space LUN addressing', which allows us to raise
> the max_lun limitation to 16384.

I have added lun_format to the scsi_debug specific table in:
    http://sg.danny.cz/sg/scsi_debug.html

and enhanced the description of max_luns. Perhaps you might
check them. Hope to get this is lk 5.8 but the window is short.

> Signed-off-by: Hannes Reinecke <hare@suse.de>
Tested-by: Douglas Gilbert <dgilbert@interlog.com>

After simple fixes suggested by Bart and the kbuild robot:
Acked-by: Douglas Gilbert <dgilbert@interlog.com>
