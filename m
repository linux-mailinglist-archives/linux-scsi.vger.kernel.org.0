Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFEDEF33E
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Nov 2019 03:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbfKECGx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Nov 2019 21:06:53 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43277 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729524AbfKECGx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 4 Nov 2019 21:06:53 -0500
Received: by mail-oi1-f194.google.com with SMTP id l20so4017404oie.10
        for <linux-scsi@vger.kernel.org>; Mon, 04 Nov 2019 18:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nMCnMk+rbZ/9xPoJru/AoRDpzV80wzSGoVSoZwi74xM=;
        b=urDWydfAeFKQVTo778diSA9ScD4ADqHXP5Q4+IfbxbT2JsCwQr3ltHb+f9VGZg+XUP
         b0C32xHQi3CDpkXC8kohF98exLX6knxWj55eGOfUcOM4ZbbgWUIRcevVRHXROIEhW3oJ
         +vrKF4KMrTupBypYaZ95CRcaXOo6NIbmb6yla5jDkixOPAfRP/2AXYmJWy1XnAAepXFI
         3S8+ZKjXNEe50wzxaNqHF1sa5NqyA5eG6PtoUuXlnZU38Mb7jweggP9aT9UsxqS8bnJe
         j0oI3PapMx5HXslwmrHDcg3/AUhiw32CWZy5KxZ6ygSkQMHBSbcptqEzf1dcGxQx8MK7
         fn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMCnMk+rbZ/9xPoJru/AoRDpzV80wzSGoVSoZwi74xM=;
        b=D4BEyLfpYhFgePr98tSvbwGhO14otPxW18CHvFi8C2HuS2whfKXeFvSMQC5Uhd4Q8J
         iUWyF3DdONfXvgtIBXblJo+5BxQ2XDaEhuVlP/ItmBdKwDHEaC+qWSpBYyUjTA0RmjoJ
         5r9xRQnCBbYZRA9GK4fIKxLCcC3gW4eGcqzomlJzrMssEviDyn1V/nG1Of2Y9yQ3KnP+
         AWlSb1EwHRVcxg6AfO9aYstJAZo23naD2z8FmlVQ3Bz4u07/oxSFoZ96HuyPaKLFqOjT
         jb2BDRitqueBfEqNXz9CFDKDUHPQt/dQzXCnNsQ0eMiTuWblNLcUmeTVHCfRXNkv14Dz
         vRTg==
X-Gm-Message-State: APjAAAVcBQFGG87f4cNDssAg1svGetjACQCkGSpOPWyj3zSbUldpwjov
        7zBNcJM2CmuhTmF34mxqZ3tgu1zL15gbzCTG1yk=
X-Google-Smtp-Source: APXvYqzlZ3ewv2GM5Uv4HHWZBJLcVVntxSwCY8zO1yhJ0bze5HCdi19KjRh6hPYHDMdsG4KAsMAxG8ucjvioWpKpsa0=
X-Received: by 2002:a05:6808:1c7:: with SMTP id x7mr1848736oic.67.1572919612420;
 Mon, 04 Nov 2019 18:06:52 -0800 (PST)
MIME-Version: 1.0
References: <20191104090151.129140-1-hare@suse.de> <20191104090151.129140-8-hare@suse.de>
 <36165b2d-9a16-d2b3-2221-97515af3576c@acm.org>
In-Reply-To: <36165b2d-9a16-d2b3-2221-97515af3576c@acm.org>
From:   adam radford <aradford@gmail.com>
Date:   Mon, 4 Nov 2019 18:06:41 -0800
Message-ID: <CAHtARFGwcnUMUytAr7h_JqwZqs=3kgyp7e7J_Prz14vM1QuSSg@mail.gmail.com>
Subject: Re: [PATCH 07/52] 3w-xxxx: use standard SAM status codes
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Nov 4, 2019 at 9:39 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 11/4/19 1:01 AM, Hannes Reinecke wrote:
> > Use standard SAM status codes and omit the explicit shift to convert
> > from linux-specific ones.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Acked-by: Adam Radford <aradford@gmail.com>
