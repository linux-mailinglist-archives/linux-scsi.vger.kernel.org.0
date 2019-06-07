Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7FE3843F
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 08:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfFGGUY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Jun 2019 02:20:24 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39123 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfFGGUY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 7 Jun 2019 02:20:24 -0400
Received: by mail-ua1-f66.google.com with SMTP id j8so247636uan.6
        for <linux-scsi@vger.kernel.org>; Thu, 06 Jun 2019 23:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=slG7ONZ/1KWowwqorMrKH1HnwoSktnbQvPFCVYDcYCI=;
        b=IarPCEXy8VP7MUHmmmh70ArZervIbG3SfDrzwxH2tsHMXc7ZPBQmcwOIwwIv/4kn5W
         nzhlX3A51lj/7T8ySHi5CrY8kvE50PBjhAn9mQuBsdx52rs85JfyapxARkrx8j6hnjlb
         rt/x37/cgiY83tR+Fx0hImn+7noLT8knTy+e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=slG7ONZ/1KWowwqorMrKH1HnwoSktnbQvPFCVYDcYCI=;
        b=Da9eJqcxeBLWW5gqXQTaGQcEZNW4p5vzMkVtwhLw6MyNTjL07PEvy3u2xiw04Ee8eB
         DEuTkxeRAAFZfj5P5rETimZl6tDsZFIU82JmNDKZJwXaHhsYnRcsPc5MSEhYSu9J4Yme
         fimsz9ElYFcU89gUgaLX0oPRihj4fjOVy+ha/qj7AP6Wv20TuGIPQqe/KYMLUUDO3SG4
         X94MA/oKZM9rk0Hb6IlBEdt58M4AEYpu29GFNA0wYQqwkkNXwLNdJs6GoUC/6M0/DRu2
         Vn6V7AREQ7w5jxIbpS2cW6hpY3ceZn6IrAJS8lxa27ujFfsoj04jztUyxLaboskvIt03
         +11w==
X-Gm-Message-State: APjAAAUCxgtQ/75+xI2g/QnZoqW6e1h3Fkzrjx+fCpiHoo7uQ367C690
        ZoxxDjROcgGYpokR4lygvQvKUZzWOCyZPXcjFAmDFQ==
X-Google-Smtp-Source: APXvYqxlCMHhxCH2MD2uivBm10Ye9h1j01wzHK/Z6b9yfITdC+zIRh9uXVeFXFrnIgfS4nkdZtndWP6Ib/Nzo1E5iuE=
X-Received: by 2002:ab0:14cb:: with SMTP id f11mr26509554uae.24.1559888423403;
 Thu, 06 Jun 2019 23:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190529160041.7242-1-thenzl@redhat.com> <20190529160041.7242-2-thenzl@redhat.com>
In-Reply-To: <20190529160041.7242-2-thenzl@redhat.com>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Fri, 7 Jun 2019 11:50:12 +0530
Message-ID: <CAL2rwxodnKw0saOik9MX4wFm5zWzgQfbrfiSXgFJHeMejjPJcQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] megaraid_sas: make max_sectors visible in sys
To:     Tomas Henzl <thenzl@redhat.com>
Cc:     Linux SCSI List <linux-scsi@vger.kernel.org>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, May 29, 2019 at 9:30 PM Tomas Henzl <thenzl@redhat.com> wrote:
>
> Support is easier with all driver parameters visible in sysfs.
>
> Signed-off-by: Tomas Henzl <thenzl@redhat.com>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>

> ---
>  drivers/scsi/megaraid/megaraid_sas_base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index 3a9128ed3..3752daab0 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -64,7 +64,7 @@
>   * Will be set in megasas_init_mfi if user does not provide
>   */
>  static unsigned int max_sectors;
> -module_param_named(max_sectors, max_sectors, int, 0);
> +module_param_named(max_sectors, max_sectors, int, S_IRUGO);
>  MODULE_PARM_DESC(max_sectors,
>         "Maximum number of sectors per IO command");
>
> --
> 2.20.1
>
