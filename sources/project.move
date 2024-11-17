module DecentralizedCertificateVerificationPlatform::Platform {
    use aptos_framework::signer;

    /// Struct representing a certificate.
    struct Certificate has store, key {
        owner: address,            // Address of the person who owns the certificate
        certificate_id: u64,       // Unique identifier for the certificate
        issued_by: address,        // Issuer's address
        is_valid: bool,            // Whether the certificate is valid
    }

    /// Function to register a new certificate.
    public fun register_certificate(owner: &signer, certificate_id: u64, issued_by: address) {
        let cert = Certificate {
            owner: signer::address_of(owner),
            certificate_id,
            issued_by,
            is_valid: true,
        };
        move_to(owner, cert);
    }

    /// Function to verify a certificate.
    public fun verify_certificate(cert_owner: address, certificate_id: u64): bool acquires Certificate {
    let cert = borrow_global<Certificate>(cert_owner);
    if (cert.certificate_id == certificate_id) {
        cert.is_valid
    } else {
        false
    }
}
}

