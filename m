Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C13C2C811E
	for <lists+linux-scsi@lfdr.de>; Mon, 30 Nov 2020 10:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgK3Jer (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 30 Nov 2020 04:34:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:34590 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbgK3Jeq (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 30 Nov 2020 04:34:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1074EAC6A;
        Mon, 30 Nov 2020 09:34:05 +0000 (UTC)
Date:   Mon, 30 Nov 2020 10:34:04 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc:     trix@redhat.com, njavali@marvell.com, jejb@linux.ibm.com,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: qla2xxx: remove trailing semicolon in macro
 definition
Message-ID: <20201130093404.xjow7bddb5jw3myj@beryllium.lan>
References: <20201127182741.2801597-1-trix@redhat.com>
 <20201130091753.4wyrzlbrqszdzy6s@beryllium.lan>
 <CAHo-Oow4nPR9ODya-cPHZrsMFFPF9aUJJXfrFqLCxRzmJVMrmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHo-Oow4nPR9ODya-cPHZrsMFFPF9aUJJXfrFqLCxRzmJVMrmA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Nov 30, 2020 at 01:29:19AM -0800, Maciej Żenczykowski wrote:
> On Mon, Nov 30, 2020 at 1:23 AM Daniel Wagner <dwagner@suse.de> wrote:
> > >  #define QLA_QPAIR_MARK_NOT_BUSY(__qpair)             \
> > > -     atomic_dec(&__qpair->ref_count);                \
> > > +     atomic_dec(&__qpair->ref_count)         \
> >
> > Nitpick, please insert an additional tab after the remove so that the
> > backlashes align again.
> >
> 
> Uhm, if there's no semicolon, then presumably it's the final line of the
> macro, and thus there should be no tabs and no backslash at the end of the
> line.

Right! Didn't realize it. The backslash should be removed.
