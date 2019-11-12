Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50331F94DA
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Nov 2019 16:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfKLP5B (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 Nov 2019 10:57:01 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46688 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfKLP5B (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 12 Nov 2019 10:57:01 -0500
Received: by mail-qk1-f195.google.com with SMTP id h15so14819858qka.13
        for <linux-scsi@vger.kernel.org>; Tue, 12 Nov 2019 07:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=1IbLopXeOg4pNSDD/hzaOk4V2cDKuDqWmgdqhra/5Yc=;
        b=X036rUhYi/tk6XMuC+TlnWVIoBug5wpseQO90+5c/0HKMi190Gk+PymMdlAv5AaNi0
         b6Pkt4BN49UqD+GpnbdxkywsfntW5OqCu36YcVKJIOG5Nz7X9pzTbqx40orHCa0dUHUB
         ExIZnyafQUc85jPZoIn8ZVb2jcs10Qx9Yx3M+Zn3Z////E3MEgqzG1fsov2QM0z+cONf
         UBTfT3crX+Ue86b4d8SrNN43uoYa/h60J0Q7ukQS8glRnQQSrA/0BoZ9oloWgmTLGhuD
         pfsbaTMIjW8mW+c+C+IZueuXKfB541KH/2YVupzNXgSmRu4VWpLovJ32CwulSRqdwurw
         1rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=1IbLopXeOg4pNSDD/hzaOk4V2cDKuDqWmgdqhra/5Yc=;
        b=V1+3E7HO0lvd86rPWbmS0ikWmg5+eF1igqQrNjk5QRbrgp9n7b8I0ofyXFSX8W4CMT
         /TEWZ76B/TfrF9w4TM3Hcp4nKfLH6+Et6D7lq1cs1qBNJWRVDuFGoQw/NuF4jN2RK28c
         60+OfhHEkkdZuEV5D5jwcuiu5t4yF2nIJJ1ZeLpHFK2UxC3Uju3j/3f7GH7h4Iw6M7IN
         795tCw9FQuPD3UUlc++PxOx8vjZ9+o659x9vkcf2g10AMh4KZ/v+EBIzlWlCP+1nkezh
         Y95umBTn6Z990UXXAfUn0wqAcx9tnFZ+3JmAMnv+mh2/dFIent+XHUfFq2Covr5WaRkW
         4kyw==
X-Gm-Message-State: APjAAAU0iHH9wFwJBWtCikbi3day+AA43N6LZef+/4c//ErCf1fe37xH
        2KxRoVBJ1OrT2eNp8vJLB56x0bGKRyMXUq8Q0G8=
X-Google-Smtp-Source: APXvYqwitKcOQRBvqOhHd9wRBN/yXvhrgJ8qjKDopMsxcGlYn26De2Lhx/9mFob7HKaqt6qBv2TJhLJ+m9ldPAhflfs=
X-Received: by 2002:ae9:eb07:: with SMTP id b7mr16017099qkg.104.1573574220769;
 Tue, 12 Nov 2019 07:57:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:ed24:0:0:0:0:0 with HTTP; Tue, 12 Nov 2019 07:56:59
 -0800 (PST)
Reply-To: lexx1759@gmail.com
From:   Lexx Jones <frankkoswells11@gmail.com>
Date:   Tue, 12 Nov 2019 15:56:59 +0000
Message-ID: <CAAe31MkR_barQK4T5X4GWpZgXshLFERbTCjXyVMv9mT+6o54Dg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

16nXnNeV150g15nXp9eZ16jXmSwg15bXlSDXlNek16LXnSDXlNep16DXmdeZ15Qg16nXqdec15fX
qteZINec15og15DXqiDXlNeU15XXk9ei15Qg15TXlteVLCDXldeR15vXnCDXlteQ16og15zXkCDX
lNem15zXl9eqDQrXnNei16DXldeqLCDXnteT15XXoj8g157XlCDXlNeR16LXmdeUPw0KDQrXkNeg
15kg157Xl9eb15Qg15zXqteS15XXkdeq15oNCg==
