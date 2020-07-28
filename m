Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D5823136D
	for <lists+linux-scsi@lfdr.de>; Tue, 28 Jul 2020 22:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgG1UCp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 28 Jul 2020 16:02:45 -0400
Received: from netrider.rowland.org ([192.131.102.5]:34291 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728849AbgG1UCp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 28 Jul 2020 16:02:45 -0400
Received: (qmail 1512022 invoked by uid 1000); 28 Jul 2020 16:02:43 -0400
Date:   Tue, 28 Jul 2020 16:02:43 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Bart Van Assche <bvanassche@acm.org>, jejb@linux.ibm.com,
        Can Guo <cang@codeaurora.org>, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCH] scsi: sd: add runtime pm to open / release
Message-ID: <20200728200243.GA1511887@rowland.harvard.edu>
References: <20200706164135.GE704149@rowland.harvard.edu>
 <d0ed766b-88b0-5ad5-9c10-a4c3b2f994e3@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0ed766b-88b0-5ad5-9c10-a4c3b2f994e3@puri.sm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Jul 28, 2020 at 09:02:44AM +0200, Martin Kepplinger wrote:
> Hi Alan,
> 
> Any API cleanup is of course welcome. I just wanted to remind you that
> the underlying problem: broken block device runtime pm. Your initial
> proposed fix "almost" did it and mounting works but during file access,
> it still just looks like a runtime_resume is missing somewhere.

Well, I have tested that proposed fix several times, and on my system 
it's working perfectly.  When I stop accessing a drive it autosuspends, 
and when I access it again it gets resumed and works -- as you would 
expect.

> As we need to have that working at some point, I might look into it, but
> someone who has experience in the block layer can surely do it more
> efficiently.

I suspect that any problems you still face are caused by something else.

Alan Stern
