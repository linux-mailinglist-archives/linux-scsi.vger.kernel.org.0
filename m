Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3081DA73F
	for <lists+linux-scsi@lfdr.de>; Wed, 20 May 2020 03:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgETBht (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 19 May 2020 21:37:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59194 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgETBht (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 19 May 2020 21:37:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id E91E62A26B9
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     lduncan@suse.com, cleech@redhat.com, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org, kernel@collabora.com,
        Khazhismel Kumykov <khazhy@google.com>
Subject: Re: [PATCH] iscsi: Fix deadlock on recovery path during GFP_IO reclaim
Organization: Collabora
References: <20200508055954.843165-1-krisman@collabora.com>
        <yq1imgrwgu7.fsf@ca-mkp.ca.oracle.com>
Date:   Tue, 19 May 2020 21:37:44 -0400
In-Reply-To: <yq1imgrwgu7.fsf@ca-mkp.ca.oracle.com> (Martin K. Petersen's
        message of "Tue, 19 May 2020 21:12:00 -0400")
Message-ID: <85y2pnmlnb.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

"Martin K. Petersen" <martin.petersen@oracle.com> writes:

> Gabriel,
>
>> iscsi suffers from a deadlock in case a management command submitted
>> via the netlink socket sleeps on an allocation while holding the
>> rx_queue_mutex,
>
> This does not apply to 5.8/scsi-queue. Please resubmit.

Hi Martin,

Apparently it conflicted with my own code coming from -next.  Sorry.  I
will resubmit as soon as I finish testing it.

-- 
Gabriel Krisman Bertazi
