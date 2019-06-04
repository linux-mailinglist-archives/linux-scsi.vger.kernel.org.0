Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67F1C34322
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 11:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfFDJ15 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 05:27:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40068 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfFDJ15 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 4 Jun 2019 05:27:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id u16so8685531wmc.5
        for <linux-scsi@vger.kernel.org>; Tue, 04 Jun 2019 02:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bP3uT0xOsWpWeV8GPMi16XlVF6iH0G03fH2BH66LHAk=;
        b=HqpU5re/rYyimOBoYdgRSjLO+2DTvSVLGlL/2bfqAdaDMwFjR4F59EMB6saBNprYHG
         I2cCFVnQN6aipBJVZY3RLsXY8Nu8Wc8An4Sl3s/W/RK28Me9Xs8XzcmYOiUWvEWM4J5z
         CL/hvVCDJvc/gw90JvfsatHWWvKNBcnYf7oOCE/wSyJ8NhRIppLX9dbND2Fsd9gcqPR1
         WYXDuShTlypChQhHkQaBsNqkFTX7/z1IuA6hkpdjStzvz+z6e/v+Khex23tnYIRvQLVi
         kJWufcRY1iUHgtfC9oHMMZo7v8EXG2To6vc6O+QCSGuVjaPr2XcltR9ll9V1PHopNXBN
         ia4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bP3uT0xOsWpWeV8GPMi16XlVF6iH0G03fH2BH66LHAk=;
        b=e3AHMRH4vDg9+OS6MdQdnp8B6zyDwi4uv1+OfMvQpFyRmuv2ek+DJ9d+lBldZHdRoW
         Oj1+PYrnILrBTbxE5/in5cM0MpxEgW4ffxmdkEgbvIhGqFC4MdeO+h6dROtk7OAM6XvT
         Gomb1HTMgd3X/J+0GO41InNr/aI3zuNgaX+LJkyd0BYNq4SuP9GPEscb6woocCA1cSD5
         IPZCsk8e2UHTVaaNue7WV82XQOZySljibtzLGoa0KOEJ7kvdjdUjHotwIbQ8Q16gjQAC
         BU4o7SwWWEpDRVWCCeV5aBYOpImriLo/zsfPDaseFHWM1uGGodG4DUtl/5E1rH3JAyFa
         mAyw==
X-Gm-Message-State: APjAAAV182gkniqStUdYr8Hbu7nLv9TMb8wvm8Yw5sMJHofRJZtkLsIb
        fe5fm0WNY2+CAm1Lacxe0t9cyf5rfGlvdD/UCVU=
X-Google-Smtp-Source: APXvYqzkrrWt5HxO5snhgWjKuk/tercDOe7/owADgO6PSCL7cCWXh3RRmzTyJ3pHMKyCQFe7Va8+vkc2d2VbxetLnAE=
X-Received: by 2002:a1c:8049:: with SMTP id b70mr16942408wmd.33.1559640474991;
 Tue, 04 Jun 2019 02:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190604082308.5575-1-ming.lei@redhat.com> <20190604082308.5575-3-ming.lei@redhat.com>
 <alpine.LNX.2.21.1906041921050.66@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1906041921050.66@nippy.intranet>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 4 Jun 2019 17:27:43 +0800
Message-ID: <CACVXFVMiZApFK5t3j3HEt7nETRnOMxNW6eJeFeMmKRyM2w_diw@mail.gmail.com>
Subject: Re: [PATCH 2/2] scsi: esp: make it working on SG_CHAIN
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Jun 4, 2019 at 5:22 PM Finn Thain <fthain@telegraphics.com.au> wrote:
>
> On Tue, 4 Jun 2019, Ming Lei wrote:
>
> > The driver supporses that there isn't sg chain, and itereate the
> > list one by one. This way is obviously wrong.
> >
> > Fixes it by sgl helper.
> >
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Ewan D. Milne <emilne@redhat.com>
> > Cc: Hannes Reinecke <hare@suse.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/scsi/esp_scsi.c | 32 +++++++++++++++++++++++++-------
> >  1 file changed, 25 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
> > index 76e7ca864d6a..58b4e059dcfb 100644
> > --- a/drivers/scsi/esp_scsi.c
> > +++ b/drivers/scsi/esp_scsi.c
> > @@ -371,6 +371,7 @@ static void esp_map_dma(struct esp *esp, struct scsi_cmnd *cmd)
> >       struct esp_cmd_priv *spriv = ESP_CMD_PRIV(cmd);
> >       struct scatterlist *sg = scsi_sglist(cmd);
> >       int total = 0, i;
> > +     struct scatterlist *sgt;
> >
> >       if (cmd->sc_data_direction == DMA_NONE)
> >               return;
> > @@ -381,14 +382,15 @@ static void esp_map_dma(struct esp *esp, struct scsi_cmnd *cmd)
> >                * a dma address, so perform an identity mapping.
> >                */
> >               spriv->num_sg = scsi_sg_count(cmd);
> > -             for (i = 0; i < spriv->num_sg; i++) {
> > -                     sg[i].dma_address = (uintptr_t)sg_virt(&sg[i]);
> > -                     total += sg_dma_len(&sg[i]);
> > +
> > +             scsi_for_each_sg(cmd, sgt, spriv->num_sg, i) {
> > +                     sgt->dma_address = (uintptr_t)sg_virt(sgt);
> > +                     total += sg_dma_len(sgt);
> >               }
> >       } else {
> >               spriv->num_sg = scsi_dma_map(cmd);
> > -             for (i = 0; i < spriv->num_sg; i++)
> > -                     total += sg_dma_len(&sg[i]);
> > +             scsi_for_each_sg(cmd, sgt, spriv->num_sg, i)
> > +                     total += sg_dma_len(sgt);
> >       }
> >       spriv->cur_residue = sg_dma_len(sg);
> >       spriv->cur_sg = sg;
> > @@ -444,7 +446,7 @@ static void esp_advance_dma(struct esp *esp, struct esp_cmd_entry *ent,
> >               p->tot_residue = 0;
> >       }
> >       if (!p->cur_residue && p->tot_residue) {
> > -             p->cur_sg++;
> > +             p->cur_sg = sg_next(p->cur_sg);
> >               p->cur_residue = sg_dma_len(p->cur_sg);
> >       }
> >  }
> > @@ -1610,6 +1612,22 @@ static void esp_msgin_extended(struct esp *esp)
> >       scsi_esp_cmd(esp, ESP_CMD_SATN);
> >  }
> >
> > +static struct scatterlist *esp_sg_prev(struct scsi_cmnd *cmd,
> > +             struct scatterlist *sg)
> > +{
> > +     int i;
> > +     struct scatterlist *tmp;
> > +     struct scatterlist *prev = NULL;
> > +
> > +     scsi_for_each_sg(cmd, tmp, scsi_sg_count(cmd), i) {
> > +             if (tmp == sg)
> > +                     break;
> > +             prev = tmp;
> > +     }
> > +
> > +     return prev;
> > +}
> > +
>
> Did you consider recording the previous scatterlist pointer using an
> additional member in struct esp_cmd_priv, to be assigned in
> esp_advance_dma()? I think it would execute faster and require less code.

Good point, will do it in V2.

Thanks,
Ming Lei
