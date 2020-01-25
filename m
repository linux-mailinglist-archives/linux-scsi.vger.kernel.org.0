Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3D8149700
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Jan 2020 18:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgAYRq2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Sat, 25 Jan 2020 12:46:28 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43498 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgAYRq2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 25 Jan 2020 12:46:28 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id ACB4528EBDA
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Lee Duncan <leeman.duncan@gmail.com>
Cc:     open-iscsi <open-iscsi@googlegroups.com>,
        Lee Duncan <lduncan@suse.com>, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, Bharath Ravi <rbharath@google.com>,
        kernel@collabora.com, Michael Christie <mchristi@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Dave Clausen <dclausen@google.com>,
        Nick Black <nlb@google.com>,
        Vaibhav Nagarnaik <vnagarnaik@google.com>,
        Anatol Pomazau <anatol@google.com>,
        Tahsin Erdogan <tahsin@google.com>,
        Frank Mayhar <fmayhar@google.com>, Junho Ryu <jayr@google.com>,
        Khazhismel Kumykov <khazhy@google.com>
Subject: Re: [PATCH RESEND v4] iscsi: Perform connection failure entirely in kernel space
Organization: Collabora
References: <20200125061925.191601-1-krisman@collabora.com>
        <F29720C3-86AC-407A-8255-9186E3AE0676@gmail.com>
Date:   Sat, 25 Jan 2020 12:46:23 -0500
In-Reply-To: <F29720C3-86AC-407A-8255-9186E3AE0676@gmail.com> (Lee Duncan's
        message of "Sat, 25 Jan 2020 09:22:02 -0800")
Message-ID: <8536c3ctu8.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Lee Duncan <leeman.duncan@gmail.com> writes:

> I’m sorry if it didn’t get through, but I sent a Reviewed-by update and the end of last week.
>
> I looked over the updates, and I said that they look good to me, and I said please re-add my:
>
> Reviewed-by: Lee Duncan <lduncan@suse.com <mailto:lduncan@suse.com>>

Hey,

Thank you very much for the quick response!  I checked here again and I didn't
get the previous email, but I see it made into the ML archive, so my apologies,
it must be something bad on my (or my employer's) setup.

Thanks,

-- 
Gabriel Krisman Bertazi
